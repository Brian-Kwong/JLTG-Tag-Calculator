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
    @Published var sortByOption: SortByOptions = .cost {
        didSet {
            sortResultsBy(sortBy: sortByOption)
        }
    }
    private var searchTask: Task<Void, Never>?

    init(forPreview: Bool = false) {
        if forPreview {
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
        departureDate: Date = Date()
    ) {
        searchRoutes(
            orgin: orgin,
            destination: destination,
            departureDate: departureDate
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
        departureDate: Date
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
                let fetchedRoutes = try await APINetworkManager.shared.getRoute(
                    from: orgin,
                    destination: destination,
                    departureDate: departureDate
                )
                self.routes = fetchedRoutes
            } catch {
                self.showRouteDetails = false
                self.routes = []
            }
            self.isLoading = false
        }
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
