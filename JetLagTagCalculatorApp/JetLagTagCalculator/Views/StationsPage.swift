//
//  StationsPage.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/15/25.
//

import SwiftUI

struct StationsPage: View {
    @ObservedObject var departuresViewModel : DeparturesViewModel
    var body: some View {
        Group {
            if departuresViewModel.isLoading {
                VStack {
                    ProgressView()
                    Text("Fetching Departure Data")
                }
            } else if departuresViewModel.departures.isEmpty {
                EmptyView()
            } else {
                List(departuresViewModel.departures) { station in
                    HStack {
                        StationCard(station: station)
                            .background(
                                NavigationLink(value: station) {
                                    EmptyView()
                                }.opacity(0)
                            ).padding(.vertical, 12)
                    }.frame(maxWidth: .infinity, alignment: .center)
                        .listRowInsets(EdgeInsets())
                }
                .listStyle(.plain)
            }
        }.navigationTitle("Nearby Stations").navigationDestination(for: RouteDeparturesResponse.self) { station in
            StationDeparturesPage(station: station)
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
