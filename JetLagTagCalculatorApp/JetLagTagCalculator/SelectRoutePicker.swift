//
//  SelectRoutePicker.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/2/25.
//

import GooglePlacesSwift
import SwiftUI

struct SelectRoutePicker: View {
    @State private var fromLocation: UserPlaceEntry = UserPlaceEntry(
        location: "",
        placeID: ""
    )
    @FocusState private var fromLocationFocused: Bool
    @State private var toLocation: UserPlaceEntry = UserPlaceEntry(
        location: "",
        placeID: ""
    )
    @FocusState private var toLocationFocused: Bool
    @State private var selectedTransitType: String = "All"
    @State private var departureDate: Date = Date()
    @State private var coinBalance: String = ""
    @StateObject private var locationManager = UserLocationManager()
    @StateObject private var googlePlacesViewModel = GooglePlacesViewModel()
    var body: some View {
        VStack {
            Form {
                Section("Location") {
                    InputFeild(
                        googlePlacesViewModel: googlePlacesViewModel,
                        locationManager: locationManager,
                        location: $fromLocation,
                        inputFocused: $fromLocationFocused,
                        placeHolderText: "Origin Station"
                    )
                    InputFeild(
                        googlePlacesViewModel: googlePlacesViewModel,
                        locationManager: locationManager,
                        location: $toLocation,
                        inputFocused: $toLocationFocused,
                        placeHolderText: "Destination Station"
                    )
                }
                Section("Options") {
                    DatePicker(
                        "Departure",
                        selection: $departureDate,
                        displayedComponents: [.date, .hourAndMinute]
                    )
                    TextField("Coin Balance", text: $coinBalance)
                        .keyboardType(.numberPad)
                }
                Section {
                    Button("Search Route") {
                    }.frame(maxWidth: .infinity, alignment: .center)
                }
            }.overlay(alignment: .top) {
                if (fromLocationFocused
                    && !googlePlacesViewModel.autoCompleteStations.isEmpty
                    && fromLocation.location != "")
                    || (toLocationFocused
                        && !googlePlacesViewModel.autoCompleteStations.isEmpty
                        && toLocation.location != "")
                {
                    VStack {
                        ForEach(
                            googlePlacesViewModel.autoCompleteStations
                                .prefix(5),
                            id: \.self
                        ) { suggestion in
                            AutoSuggestionEntry(
                                suggestion: suggestion,
                                userInput: fromLocationFocused
                                    ? $fromLocation
                                    : $toLocation,
                                inputFocused: fromLocationFocused
                                    ? $fromLocationFocused
                                    : $toLocationFocused
                            )
                        }
                    }.frame(maxWidth: .infinity)
                        .background(.ultraThinMaterial)
                        .cornerRadius(8)
                        .padding()
                        .shadow(radius: 5)
                        .offset(y: fromLocationFocused ? 60 : 110)
                }
            }
        }.navigationTitle("Route Search")
    }
}

#Preview {
    SelectRoutePicker()
}
