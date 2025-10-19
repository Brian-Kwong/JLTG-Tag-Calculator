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
    var showTrailingIcon: Bool = false
    var trailingIconName : String?
    var trailingIconColor : Color?
    var trailingIconAction : (
        (inout UserPlaceEntry, inout String?) -> Void
    )? = nil
    @Binding var errorMessage: String?
    @ObservedObject var googlePlacesViewModel: GooglePlacesViewModel
    @Binding var location: UserPlaceEntry
    @FocusState.Binding var inputFocused: Bool
    var placeHolderText: String = ""
    var body: some View {
        HStack {
            TextField(placeHolderText, text: $location.location).focused(
                $inputFocused
            )
            if showTrailingIcon {
                Button(action: {
                    Task {
                        if let action = trailingIconAction {
                            action(&location, &errorMessage)
                        }
                    }
                }) {
                    Image(
                        systemName: trailingIconName ?? location.location != "" ? "xmark.circle.fill" : "location.fill",
                    )
                    .foregroundColor(trailingIconColor ?? (location.location != "" ? .gray : .blue))
                }
                .padding(.trailing, 8)
            }
        }
        .onChange(of: location.location) { oldValue, newValue in
            if newValue != "" {
                googlePlacesViewModel
                    .fetchForStations(
                        input: newValue,
                        currentLocation: UserLocationManager.shared
                            .userLocation
                            ?? CLLocation(latitude: 0, longitude: 0)
                    )
            }
        }
        .onChange(of: inputFocused) { oldValue, newValue in
            if newValue {
                UserLocationManager.shared.stattUpdatingLocation()
            } else {
                UserLocationManager.shared.stopUpdatingLocation()
            }
        }
        .onChange(of: location.placeID) { oldValue, newValue in
            if newValue != "" {
                googlePlacesViewModel.fetchPlaceCordinates(placeID: newValue) { coordinate in
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
                errorMessage: Binding.constant(""),
                googlePlacesViewModel: GooglePlacesViewModel(),
                location: $fromLocation,
                inputFocused: $fromLocationFocused
            )
        }
    }
    return InputFeildPreviewWrapper()
}
