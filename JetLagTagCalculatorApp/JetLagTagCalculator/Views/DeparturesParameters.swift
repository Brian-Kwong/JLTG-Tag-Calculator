//
//  DeparturesParameters.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/15/25.
//

import SwiftUI
internal import _LocationEssentials

enum SearchRadiusSize: String, CaseIterable, Identifiable {
    case QUARTER_KM = "0.25"
    case HALF_KM = "0.5"
    case ONE_KM = "1"
    case TWO_KM = "2"
    case FUVE_KM = "5"
    case TEN_KM = "10"
    var id: Self { self }
}

struct DeparturesParameters: View {
    @ObservedObject var departuresViewModel: DeparturesViewModel
    @State var didAppear = false

    @StateObject private var googlePlacesViewModel = GooglePlacesViewModel()
    @State private var searchLocation: UserPlaceEntry = UserPlaceEntry(
        location: "Current Location",
        placeID: ""
    )
    @State private var radius: SearchRadiusSize = SearchRadiusSize.ONE_KM

    @State private var departureDate: Date = Date()

    @State private var selectedModesOfTransport: Set<TransportationModes> = Set(
        TransportationModes.allCases
    )

    @FocusState private var searchLocationFocused: Bool

    @State private var entryError: String?

    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass

    private func submitSearch() {
        if searchLocation.location == "Current Location" {
            if let userLocation = UserLocationManager.shared.userLocation
            {
                searchLocation.coordinate = Coordinate(
                    latitude: userLocation.coordinate.latitude,
                    longitude:  userLocation.coordinate.longitude
                )
            } else {
                departuresViewModel.errorIcon = "location.slash"
                departuresViewModel.errorMessage =
                "Location not available. Please either enable location services or use the search filter to search for a specific area."
                departuresViewModel.showDepartures = true
            }
        }

        departuresViewModel.searchDepartures(
            location: searchLocation,
            radius: String(
                Int(
                    Double(
                        (radius.rawValue as NSString).doubleValue * 1000
                    )
                )
            ),
            departureDate: departureDate,
            modesOfTransport: selectedModesOfTransport
        )
    }

    var body: some View {
        let isCompact =
            horizontalSizeClass == .compact && verticalSizeClass == .compact
        VStack {
            Form {
                Section("Location") {
                    InputFeild(
                        showTrailingIcon: searchLocationFocused,
                        trailingIconAction: searchLocation.location != ""
                            ? clearLocation : setCurrentLocation,
                        googlePlacesViewModel: googlePlacesViewModel,
                        location: $searchLocation,
                        inputFocused: $searchLocationFocused,
                        placeHolderText: "Search Area"
                    )
                    Picker("Radius", selection: $radius) {
                        ForEach(SearchRadiusSize.allCases) { radius in
                            Text("\(radius.rawValue.capitalized) km")
                        }
                    }
                }
                Section("Additional Opitions") {
                    DatePicker(
                        "Departure",
                        selection: $departureDate,
                        displayedComponents: [.date, .hourAndMinute]
                    )
                    TransportModeSelector(
                        selectedModesOfTransport: $selectedModesOfTransport
                    )
                }
                Section {
                    Button("Update Search Parameters") {
                        Task {
                            if searchLocation.location == ""
                                || searchLocation.coordinate == nil
                            {
                                entryError = "Please enter a valid search location"
                            } else if selectedModesOfTransport.isEmpty {
                                entryError = "Please select at least one mode of transport"
                            } else {
                                submitSearch()
                            }
                        }
                    }.frame(maxWidth: .infinity, alignment: .center)
                }
            }.onAppear {
                Task {
                    if !didAppear {
                        submitSearch()
                        didAppear = true
                    }
                }
            }
        }.navigationTitle("Departures Searh").navigationDestination(
            isPresented: $departuresViewModel.showDepartures
        ) {
            StationsPage(departuresViewModel: departuresViewModel)
        }.overlay(alignment: .top) {
            if searchLocationFocused {
                NavOverlay(
                    inputFocused: $searchLocationFocused,
                    googlePlacesViewModel: googlePlacesViewModel,
                    userLocation: $searchLocation,
                    overlayOffsetY: isCompact ? 60 : 70
                )
            }
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
    struct DepartureParameters: View {
        @StateObject var departuresViewModel = DeparturesViewModel(
            forPreview: true
        )
        var body: some View {
            DeparturesParameters(departuresViewModel: departuresViewModel)
        }
    }
    return DepartureParameters()
}
