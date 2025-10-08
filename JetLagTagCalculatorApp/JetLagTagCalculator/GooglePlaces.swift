//
//  GooglePlaces.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/4/25.
//

internal import Combine
import CoreLocation
import Foundation
import GooglePlacesSwift
import _ConfidentialKit

class GooglePlacesViewModel: ObservableObject {
    
    @Published var autoCompleteStations: [AutocompletePlaceSuggestion] = []
    private var placesClient = PlacesClient.shared
    private var sessionToken = AutocompleteSessionToken()
    private var searchTask: Task<Void, Never>?
    private var placeCordiateSearch: Task<Void, Never>?
    func fetchForStations(input: String, currentLocation: CLLocation) {
        // Cancel any existing search task
        searchTask?.cancel()

        // Check if input is empty
        guard !input.isEmpty else {
            DispatchQueue.main.async {
                self.autoCompleteStations = []
            }
            return
        }
        
        searchTask = Task {
            let filter = AutocompleteFilter(
                types: [.transitStation, .cityHall, .airport, .trainStation],
                origin: currentLocation,
                coordinateRegionBias: CircularCoordinateRegion(
                    center: currentLocation.coordinate,
                    radius: 50000  // 50 km radius
                )
            )
            let autoCompleteReq = AutocompleteRequest(
                query: input,
                sessionToken: sessionToken,
                filter: filter
            )
            switch await placesClient
                .fetchAutocompleteSuggestions(with: autoCompleteReq)
            {
            case .success(let response):
                DispatchQueue.main.async {
                    var mySugguestions : [AutocompletePlaceSuggestion] = []
                    for suggestion in response {
                        switch suggestion {
                        case .place(let placeSuggestion):
                            mySugguestions.append(placeSuggestion)
                        @unknown default:
                            fatalError("Unknown suggestion type")
                        }
                    }
                    self.autoCompleteStations = mySugguestions
                }
            case .failure(let error):
                print("Error fetching autocomplete suggestions: \(error)")
                DispatchQueue.main.async {
                    self.autoCompleteStations = []
                }
            }
        }
    }
    func fetchPlaceCordinates(placeID: String, setter: ((CLLocationCoordinate2D?) -> Void)? = nil) {
        placeCordiateSearch?.cancel()
        guard !placeID.isEmpty else {
            return
        }
        placeCordiateSearch = Task {
            let fetchPlace = FetchPlaceRequest(
                placeID: placeID, placeProperties: [.coordinate]
            )
            switch await placesClient.fetchPlace(with: fetchPlace) {
            case .success(let place):
                setter?(place.location)
            case .failure(let placesError):
                print("Error fetching place details: \(placesError)")
            }
        }
    }
}
