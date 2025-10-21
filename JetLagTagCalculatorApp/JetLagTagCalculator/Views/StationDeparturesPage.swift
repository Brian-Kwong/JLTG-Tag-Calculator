//
//  StationDeparturesPage.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/14/25.
//

import SwiftUI

struct StationDeparturesPage: View {
    @StateObject private var stationDeparturesViewModel:
        StationDeparturesViewModel

    init(station: RouteDeparturesResponse) {
        _stationDeparturesViewModel = StateObject(
            wrappedValue: StationDeparturesViewModel(station: station)
        )
    }

    var body: some View {
        VStack {
            StationCard(station: stationDeparturesViewModel.station)
            List(
                stationDeparturesViewModel.station.departures.indices,
                id: \.self
            ) { idx in
                let departure = stationDeparturesViewModel.station.departures[
                    idx
                ]
                Departure(departure: departure).padding(.vertical, 8).frame(maxWidth: .infinity, alignment: .center)
                    .listRowInsets(EdgeInsets())
            }
        }.listStyle(.plain).padding(.horizontal, 12).navigationTitle(
            "Next Departures"
        ).toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                SortByButton(
                    selectedSortOption: $stationDeparturesViewModel.sortByOption,
                )
            }
        }
    }
}

#Preview {
    struct StationDeparturesPreviewWrapper: View {
        @StateObject var routeResultsViewModel = DeparturesViewModel(
            forPreview: true
        )
        var body: some View {
            if let firstStation = routeResultsViewModel.departures.first {
                StationDeparturesPage(station: firstStation)
            } else {
                Text("No Departure Data")
            }
        }
    }
    return StationDeparturesPreviewWrapper()
}
