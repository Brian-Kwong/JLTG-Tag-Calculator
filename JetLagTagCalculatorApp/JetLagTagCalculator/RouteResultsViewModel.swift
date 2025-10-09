//
//  RouteResultsViewModel.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/5/25.
//

internal import Combine
import Foundation

final class RouteResultsViewModel: ObservableObject {
    @Published var isLoading: Bool = true
    @Published var routes: [RouteResponse] = []
    @Published var sortByOption: SortByOptions = .cost {
        didSet {
            sortResultsBy(sortBy: sortByOption)
        }
    }
    private var searchTask: Task<Void, Never>?
    private var baseOrigin: UserPlaceEntry = UserPlaceEntry(
        location: "Paris, France",
        placeID: "ChIJD7fiBh9u5kcRYJSMaMOCCwQ",
        coordinate: Coordinate(latitude: 48.8566, longitude: 2.3522)
    )
    private var baseDestination: UserPlaceEntry = UserPlaceEntry(
        location: "Zermatt, Switzerland",
        placeID: "ChIJ0Wk3b6p1hkcR4vM8F2kH8gE",
        coordinate: Coordinate(latitude: 46.0207, longitude: 7.7491)
    )


    init(orgin: UserPlaceEntry?, destination: UserPlaceEntry?) {
        searchRoutes(orgin: orgin ?? baseOrigin, destination: destination  ?? baseDestination)
    }

    func searchRoutes(orgin: UserPlaceEntry, destination: UserPlaceEntry) {
        searchTask?.cancel()
        searchTask = Task {
            self.isLoading = true
            do {
                let fetchedRoutes = try await APINetworkManager.shared.getRoute(
                    from: orgin,
                    destination: destination
                )
                self.routes = fetchedRoutes
            } catch {
                print("Error fetching routes: \(error)")
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
