//
//  inputFeild.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/5/25.
//

import CoreLocation
import SwiftUI

struct Coordinate: Hashable {
    var latitude: Double
    var longitude: Double
}

struct UserPlaceEntry: Hashable {
    var location: String
    var placeID: String
    var coordinate: Coordinate?
}

struct InputFeild: View {
    @ObservedObject var googlePlacesViewModel: GooglePlacesViewModel
    @ObservedObject var locationManager: UserLocationManager
    @Binding var location: UserPlaceEntry
    @FocusState.Binding var inputFocused: Bool
    var placeHolderText: String = ""
    var body: some View {
        TextField(placeHolderText, text: $location.location).focused(
            $inputFocused
        ).onChange(of: location.location) {
            oldValue,
            newValue in
            if newValue != "" {
                googlePlacesViewModel
                    .fetchForStations(
                        input: newValue,
                        currentLocation: locationManager
                            .userLocation
                            ?? CLLocation(latitude: 0, longitude: 0)
                    )
            }
        }.onChange(of: inputFocused) {
            oldValue,
            newValue in
            if newValue {
                locationManager.stattUpdatingLocation()
            } else {
                locationManager.stopUpdatingLocation()
            }
        }.onChange(of: location.placeID) {
            oldValue,
            newValue in
            if newValue != "" {
                googlePlacesViewModel.fetchPlaceCordinates(placeID: newValue) {
                    coordinate in
                    guard let coordinate else {
                        return
                    }
                    location.coordinate = Coordinate(
                        latitude: coordinate.latitude,
                        longitude: coordinate.longitude
                    )
                }
            }
        }
    }
}

#Preview {
    struct InputFeildPreviewWrapper: View {
        @State private var fromLocation = UserPlaceEntry(
            location: "",
            placeID: ""
        )
        @FocusState private var fromLocationFocused: Bool
        var body: some View {
            InputFeild(
                googlePlacesViewModel: GooglePlacesViewModel(),
                locationManager: UserLocationManager(),
                location: $fromLocation,
                inputFocused: $fromLocationFocused
            )
        }
    }
    return InputFeildPreviewWrapper()
}
