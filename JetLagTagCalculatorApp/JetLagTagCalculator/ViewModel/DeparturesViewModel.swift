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
    @Published var showDepartures: Bool = true
    @Published var errorIcon: String? = nil
    @Published var errorMessage: String? = nil
    private var searchTask: Task<Void, Never>? = nil
    private var location : UserPlaceEntry? = nil
    private var departureDate : Date? = nil
    
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
    
    func searchDepartures(
        location: UserPlaceEntry,
        departureDate: Date,
        refresh: Bool = false
    ) {
        searchTask?.cancel()
        searchTask = Task {
            self.isLoading = true
            self.showDepartures = true
            do {
                if location.coordinate == nil {
                    self.departures = []
                    self.isLoading = false
                    self.showDepartures = false
                    return
                }
                self.location = location
                self.departureDate = departureDate
                let fetchedDepartures = try await APINetworkManager.shared.getDepartures(
                    location: location,
                    dateTime: departureDate,
                    withCache: refresh
                )
                self.departures = fetchedDepartures
            } catch RouteFetchErrors.invalidCredentials {
                self.errorIcon = "lock.shield"
                self.errorMessage = "Authentication error. Please try again."
                self.departures = []
            } catch RouteFetchErrors.noDeparturesFound {
                self.errorIcon = "circle.badge.questionmark"
                self.errorMessage = "No departures found for the selected locations and time."
                self.departures = []
            } catch RouteFetchErrors.invalidCoordinates {
                self.errorIcon = "mappin.slash"
                self.errorMessage = "Invalid coordinates provided. Please check the locations and retry."
                self.departures = []
            } catch RouteFetchErrors.invalidResponse {
                self.errorIcon = "exclamationmark.triangle"
                self.errorMessage = "Received an invalid response from the server."
                self.departures = []
            } catch RouteFetchErrors.decodingError {
                self.errorIcon = "xmark.octagon"
                self.errorMessage = "Failed to decode the response data."
                self.departures = []
            } catch RouteFetchErrors.invalidURL {
                self.errorIcon = "link.badge.plus"
                self.errorMessage = "The request URL is invalid."
                self.departures = []
            } catch {
                self.errorIcon = "exclamationmark.octagon"
                self.errorMessage = "An unexpected error occurred: \(error.localizedDescription)"
                self.departures = []
            }
            self.isLoading = false
        }
    }
}

