//
//  RouteResultsViewModel.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/5/25.
//

internal import Combine
import Foundation

final class RoutesViewModel: ObservableObject {
    @Published var showRouteDetails: Bool = false
    @Published var isLoading: Bool = false
    @Published var routes: [RouteResponse] = []
    @Published var errorMessage: String?
    @Published var errorIcon: String?
    @Published var userBalance: Int = 2000
    @Published var lowBalanceWarningShown: Bool = false
    @Published var sortByOption: SortByOptions = .cost {
        didSet {
            sortResultsBy(sortBy: sortByOption)
        }
    }
    private var searchTask: Task<Void, Never>?
    
    private var origin: UserPlaceEntry?
    private var destination: UserPlaceEntry?
    private var departureDate: Date?
    private var selectedModesOfTransport : Set<TransportationModes>?

    init(forPreview: Bool = false) {
        if forPreview {
            self.isLoading = true
            if let localResults = fetchResultsLocally() {
                self.routes = localResults
                self.isLoading = false
            } else {
                self.routes = []
                self.isLoading = false
            }
        }
    }

    func performSearch(
        orgin: UserPlaceEntry,
        destination: UserPlaceEntry,
        departureDate: Date = Date(),
        modesOfTransport: Set<TransportationModes>
    ) {
        searchRoutes(
            orgin: orgin,
            destination: destination,
            departureDate: departureDate,
            modesOfTransport: modesOfTransport
        )
    }

    /*
     Used only for debugging and previewing UI with mock data
     */
    func fetchResultsLocally() -> [RouteResponse]? {
        // For now use the mock data
        // Print statements for dev debugging
        let jsonDecoder = JSONDecoder()
        guard
            let fileURL = Bundle.main.url(
                forResource: "MockResponse",
                withExtension: "json"
            )
        else {
            print("Failed to locate mockRouteResponse.json in bundle.")
            return nil
        }
        guard let mockData = try? Data(contentsOf: fileURL) else {
            print("Failed to load mockRouteResponse.json from bundle.")
            return nil
        }
        do {
            let decodedResponse = try jsonDecoder.decode(
                [RouteResponse].self,
                from: mockData
            )
            return decodedResponse
        } catch {
            print("Failed to decode mockRouteResponse.json: \(error)")
        }
        return nil
    }

    func searchRoutes(
        orgin: UserPlaceEntry,
        destination: UserPlaceEntry,
        departureDate: Date,
        modesOfTransport: Set<TransportationModes>,
        refresh: Bool = false
    ) {
        searchTask?.cancel()
        searchTask = Task {
            self.isLoading = true
            self.showRouteDetails = true
            do {
                if orgin.coordinate == nil || destination.coordinate == nil {
                    self.routes = []
                    self.isLoading = false
                    self.showRouteDetails = false
                    return
                }
                self.origin = orgin
                self.destination = destination
                self.departureDate = departureDate
                self.selectedModesOfTransport = modesOfTransport
                let fetchedRoutes = try await APINetworkManager.shared.getRoute(
                    from: orgin,
                    destination: destination,
                    departureDate: departureDate,
                    modesOfTransport: modesOfTransport,
                    withCache: !refresh
                )
                // Find the cheapest route and see if user can afford it
                if let cheapestRoute = fetchedRoutes.min(by: { $0.totalCost < $1.totalCost }) {
                    if cheapestRoute.totalCost > userBalance && !refresh{
                        lowBalanceWarningShown = true
                    }
                }
                self.routes = fetchedRoutes
            } catch RouteFetchErrors.invalidCredentials {
                self.errorIcon = "lock.shield"
                self.errorMessage = "Authentication error. Please try again."
                self.routes = []
            } catch RouteFetchErrors.invalidTransportMode {
                self.errorIcon = "car.fill"
                self.errorMessage = "One or more selected transportation modes are invalid."
                self.routes = []
            } catch RouteFetchErrors.noRoutesFound {
                self.errorIcon = "circle.badge.questionmark"
                self.errorMessage = "No routes found for the selected locations and time."
                self.routes = []
            } catch RouteFetchErrors.invalidCoordinates {
                self.errorIcon = "mappin.slash"
                self.errorMessage = "Invalid coordinates provided. Please check the locations and retry."
                self.routes = []
            } catch RouteFetchErrors.invalidResponse {
                self.errorIcon = "exclamationmark.triangle"
                self.errorMessage = "Received an invalid response from the server."
                self.routes = []
            } catch RouteFetchErrors.decodingError {
                self.errorIcon = "xmark.octagon"
                self.errorMessage = "Failed to decode the response data."
                self.routes = []
            } catch RouteFetchErrors.invalidURL {
                self.errorIcon = "link.badge.plus"
                self.errorMessage = "The request URL is invalid."
                self.routes = []
            } catch {
                self.errorIcon = "exclamationmark.octagon"
                self.errorMessage = "An unexpected error occurred: \(error.localizedDescription)"
                self.routes = []
            }
            self.isLoading = false
        }
    }
    
    func refresh(){
        searchRoutes(
            orgin: self.origin!,
            destination: self.destination!,
            departureDate: self.departureDate!,
            modesOfTransport: self.selectedModesOfTransport!,
            refresh: true
        )
    }

    func sortResultsBy(sortBy: SortByOptions) {
        switch sortBy {
        case .cost:
            self.routes.sort { $0.totalCost < $1.totalCost }
        case .duration:
            self.routes.sort { $0.totalDuration < $1.totalDuration }
        case .transfers:
            self.routes.sort { $0.numTransfers < $1.numTransfers }
        case .departureTime:
            self.routes.sort { $0.departureTime < $1.departureTime }
        case .arrivalTime:
            self.routes.sort { $0.arrivalTime < $1.arrivalTime }
        case .distance:
            self.routes.sort { $0.totalDistance < $1.totalDistance }
        }
    }
}
