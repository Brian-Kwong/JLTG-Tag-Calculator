//
//  StationDeparturesPage.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/14/25.
//

import SwiftUI

struct StationDeparturesPage: View {
    let station: RouteDeparturesResponse
    var body: some View {
        VStack {
            StationCard(station: station)
            List(station.departures.indices, id: \.self) { idx in
                let departure = station.departures[idx]
                Departure(departure: departure)
            }
        }.listStyle(.plain).padding(.horizontal, 12).navigationTitle(
            "Next Departures"
        )
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
