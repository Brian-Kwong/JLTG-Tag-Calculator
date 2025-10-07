//
//  RouteResultsViewModel.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/5/25.
//

internal import Combine
import Foundation

func fetchResults() -> [RouteResponse]? {
    // For now use the mock data
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

final class RouteResultsViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var routes: [RouteResponse] = []
    @Published var sortByOption: SortByOptions = .cost {
        didSet {
            sortResultsBy(sortBy: sortByOption)
        }
    }
    
    init() {
        self.isLoading = true
        if let fetchedRoutes = fetchResults() {
            self.routes = fetchedRoutes
        } else {
            self.routes = []
        }
        self.isLoading = false
    }
    
    func sortResultsBy(sortBy : SortByOptions){
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
