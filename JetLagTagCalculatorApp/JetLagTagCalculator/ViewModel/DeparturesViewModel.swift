//
//  DeparturesViewModel.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/14/25.
//

import Foundation
internal import Combine

final class DeparturesViewModel: ObservableObject {
    @Published var departures: [RouteDeparturesResponse] = []
    @Published var isLoading: Bool = true
    
    
    init(forPreview: Bool = false) {
        if forPreview {
            self.isLoading = true
            if let localResults = fetchResultsLocally() {
                self.departures = localResults
                self.isLoading = false
            } else {
                self.departures = []
                self.isLoading = false
            }
        }
    }
    
    /*
     Used only for debugging and previewing UI with mock data
     */
    func fetchResultsLocally() -> [RouteDeparturesResponse]? {
        // For now use the mock data
        // Print statements for dev debugging
        let jsonDecoder = JSONDecoder()
        guard
            let fileURL = Bundle.main.url(
                forResource: "mockDepartures",
                withExtension: "json"
            )
        else {
            print("Failed to locate mockDepartures.json in bundle.")
            return nil
        }
        guard let mockData = try? Data(contentsOf: fileURL) else {
            print("Failed to load mockDepartures.json from bundle.")
            return nil
        }
        do {
            let decodedResponse = try jsonDecoder.decode(
                [RouteDeparturesResponse].self,
                from: mockData
            )
            return decodedResponse
        } catch {
            print("Failed to decode mockDepartures.json: \(error)")
        }
        return nil
    }
}

