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
    @Published var errorMessage: String? = nil
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
                    var mySugguestions: [AutocompletePlaceSuggestion] = []
                    for suggestion in response {
                        switch suggestion {
                        case .place(let placeSuggestion):
                            mySugguestions.append(placeSuggestion)
                        @unknown default:
                            return
                        }
                    }
                    self.autoCompleteStations = mySugguestions
                    self.clearError()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.autoCompleteStations = []
                    if self.errorMessage == nil {
                        self.errorMessage = error.localizedDescription
                    }
                }
            }
        }
    }

    func fetchPlaceCordinates(
        placeID: String,
        setter: ((CLLocationCoordinate2D?) -> Void)? = nil
    ) {
        placeCordiateSearch?.cancel()
        guard !placeID.isEmpty else {
            return
        }
        placeCordiateSearch = Task {
            let fetchPlace = FetchPlaceRequest(
                placeID: placeID,
                placeProperties: [.coordinate]
            )
            switch await placesClient.fetchPlace(with: fetchPlace) {
            case .success(let place):
                setter?(place.location)
            case .failure(let placesError):
                DispatchQueue.main.async {
                    self.errorMessage = placesError.localizedDescription
                }
            }
        }
    }

    /// Clear the currently stored error message (useful when dismissing alerts)
    func clearError() {
        DispatchQueue.main.async {
            self.errorMessage = nil
        }
    }
}
