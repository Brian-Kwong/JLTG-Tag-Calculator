//
//  StationsPage.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/15/25.
//

import SwiftUI

struct StationsPage: View {
    @ObservedObject var departuresViewModel: DeparturesViewModel
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
                List(departuresViewModel.departures) { station in
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
        }.navigationTitle("Nearby Stations").navigationDestination(
            for: RouteDeparturesResponse.self
        ) { station in
            StationDeparturesPage(station: station)
        }.toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                SortByButton(
                    selectedSortOption: $departuresViewModel.stationSortByOption
                )
            }
        }
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
