//
//  StationsPage.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/15/25.
//

import SwiftUI

struct StationsPage: View {
    @ObservedObject var departuresViewModel: DeparturesViewModel
    @State private var searchText: String = ""
    @State private var isSearchPresented: Bool = false
    var filteredDepartures: [RouteDeparturesResponse] {
        if searchText.isEmpty {
            return departuresViewModel.departures
        } else {
            return departuresViewModel.departures.filter { station in
                station.station.name
                    .localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    var body: some View {
        Group {
            if departuresViewModel.isLoading {
                VStack {
                    ProgressView()
                    Text("Fetching Departure Data")
                }
            } else if departuresViewModel.errorMessage != nil {
                VStack(alignment: .center, spacing: 12) {
                    Image(
                        systemName: departuresViewModel.errorIcon
                            ?? "exclamationmark.triangle"
                    )
                    .font(.system(size: 48))
                    .foregroundColor(.red)
                    Text(" \(departuresViewModel.errorMessage!)")
                        .multilineTextAlignment(.center)
                }.containerRelativeFrame(
                    .horizontal,
                    count: 2,
                    span: 1,
                    spacing: 1,
                    alignment: .center
                )
            } else if departuresViewModel.departures.isEmpty {
                EmptyView()
            } else {
                if isSearchPresented {
                    stationList.searchable(
                        text: $searchText,
                        isPresented: $isSearchPresented,
                        prompt: "Search stations"
                    )
                } else {
                    stationList
                }
            }
        }.navigationTitle("Nearby Stations").navigationDestination(
            for: RouteDeparturesResponse.self
        ) { station in
            StationDeparturesPage(station: station)
        }.toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                SortByButton(
                    selectedSortOption: $departuresViewModel.stationSortByOption
                )
            }
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    isSearchPresented = true
                } label: {
                    Image(systemName: "magnifyingglass")
                }
            }
        }
    }

    @ViewBuilder
    private var stationList: some View {
        List(filteredDepartures) { station in
            HStack {
                StationCard(station: station)
                    .listScrollEffect()
                    .background(
                        NavigationLink(value: station) {
                            EmptyView()
                        }.opacity(0)
                    ).padding(.vertical, 8)
            }.frame(maxWidth: .infinity, alignment: .center)
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
                .listRowBackground(
                    Color.clear
                )
        }
        .listStyle(.plain)
    }
}

#Preview {
    struct StationsPagePreviewWrapper: View {
        @StateObject var departuresViewModel = DeparturesViewModel(
            forPreview: true
        )
        var body: some View {
            StationsPage(departuresViewModel: departuresViewModel)
        }
    }
    return StationsPagePreviewWrapper()
}
