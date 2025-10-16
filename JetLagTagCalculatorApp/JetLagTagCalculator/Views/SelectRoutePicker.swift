//
//  SelectRoutePicker.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/2/25.
//

import GooglePlacesSwift
import SwiftUI

struct SelectRoutePicker: View {
    @ObservedObject var routeResultsViewModel: RoutesViewModel
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
    @StateObject private var googlePlacesViewModel = GooglePlacesViewModel()
    @State private var entryError: String?
    
    // By default every mode of transport is selected
    @State private var selectedModesOfTransport : Set<TransportationModes> = Set(TransportationModes.allCases)
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    var body: some View {
        let isCompact =
            horizontalSizeClass == .compact && verticalSizeClass == .compact
        VStack {
            Form {
                Section("Location") {
                    InputFeild(
                        googlePlacesViewModel: googlePlacesViewModel,
                        location: $fromLocation,
                        inputFocused: $fromLocationFocused,
                        placeHolderText: "Origin Station"
                    )
                    InputFeild(
                        googlePlacesViewModel: googlePlacesViewModel,
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
                        .onChange(of: coinBalance) {
                            oldValue,
                            newValue in
                            if let balance = Int(coinBalance) {
                                if balance < 0 {
                                    routeResultsViewModel.userBalance = 2000
                                } else {
                                    routeResultsViewModel.userBalance = balance
                                }
                            } else {
                                routeResultsViewModel.userBalance = 2000
                            }
                        }
                    HStack{
                        ForEach(TransportationModes.allCases) {
                            transportType in
                            Spacer()
                            determineButtonIcon(
                                transportationMode: transportType,
                                selectedModes: $selectedModesOfTransport
                                
                            )
                            Spacer()
                        }
                    }
                }
                Section {
                    Button("Search Route") {
                        Task {
                            if fromLocation.location == "" || fromLocation.placeID == "" || fromLocation.coordinate == nil {
                                entryError =
                                    "Please enter a valid origin station"
                                return
                            } else if toLocation.location == "" || toLocation.placeID == "" || toLocation.coordinate == nil {
                                entryError =
                                    "Please enter a valid destination station"
                                return
                            } else if fromLocation.placeID
                                        == toLocation.placeID
                            {
                                entryError =
                                    "Origin and Destination cannot be the same"
                                return
                            }
                            routeResultsViewModel
                                .performSearch(
                                    orgin: fromLocation,
                                    destination: toLocation,
                                    departureDate: departureDate,
                                    modesOfTransport: selectedModesOfTransport
                                )
                        }
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
                        .offset(
                            y: fromLocationFocused
                                ? isCompact ? 60 : 70 : isCompact ? 120 : 130
                        )
                }
            }
        }.navigationTitle("Route Search").navigationDestination(
            isPresented: $routeResultsViewModel.showRouteDetails
        ) {
            RouteResults(routeResultsViewModel: routeResultsViewModel)
        }.alert(
            "Input Error",
            isPresented: Binding<Bool>(
                get: { entryError != nil },
                set: { newValue in
                    if !newValue {
                        entryError = nil
                    }
                }
            )
        ) {
            Button("OK") {
                entryError = nil
            }
        } message: {
            if let entryError {
                Text(entryError)
            }
        }
    }
}

#Preview {
    struct RouteSelectRoouteOpitionsPreviewWrapper: View {
        @StateObject var routeResultsViewModel = RoutesViewModel(
            forPreview: true
        )
        var body: some View {
            SelectRoutePicker(routeResultsViewModel: routeResultsViewModel)
        }
    }
    return RouteSelectRoouteOpitionsPreviewWrapper()
}
