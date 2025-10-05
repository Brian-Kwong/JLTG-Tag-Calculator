//
//  inputFeild.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/5/25.
//

import SwiftUI

struct cordinate: Hashable {
    var lat: Double
    var lng: Double
}

struct UserPlaceEntry: Hashable {
    var location: String
    var placeID: String
    var coordinate: cordinate? = nil
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
                            .userLocation!
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
        }
    }
}

#Preview {
    struct InputFeildPreviewWrapper: View {
        @State private var fromLocation = UserPlaceEntry(location: "", placeID: "")
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
