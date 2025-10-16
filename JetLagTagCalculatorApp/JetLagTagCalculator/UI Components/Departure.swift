//
//  Departure.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/14/25.
//

import SwiftUI

struct Departure: View {
    let departure: RouteDeparture
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    var body: some View {
        let isCompact = horizontalSizeClass == .compact
        HStack(alignment: .center, spacing: 24){
           createIcon(
            transportationMode: departure.line.mode,
                iconSize: 40,
               iconPadding: isCompact
               ? 15 : 20)
            ViewThatFits {
                LazyVGrid(
                    columns: Array(
                        repeating: GridItem(.flexible(), spacing: 8),
                        count: 4
                    ),
                    spacing: 10
                ) {
                    departureInfo
                }.frame(minWidth: 600, alignment: .center)
                LazyVGrid(
                    columns: Array(
                        repeating: GridItem(.flexible(), spacing: 8),
                        count: 2
                    ),
                    spacing: 10
                ) {
                    departureInfo
                }.frame(minWidth: 200, alignment: .leading)
            }
        }
    }
    
    @ViewBuilder
    private var departureInfo: some View {
        HStack {
            Image(systemName: "clock.badge")
                .frame(width: 20, height: 20)
            Text(
             extractTime(timeString: departure.time)
            )
             .multilineTextAlignment(.leading).font(
                 .system(size: TextSizes.body)
             ).foregroundStyle(.secondary)
        }.frame(maxWidth: .infinity, alignment: .leading)
        HStack {
            Circle()
                .foregroundStyle(
                 Color(
                     hexString: departure.line.color ?? "000000"
                 ) ?? .black
                )
                .frame(width: 20, height: 20)
            Text(
             departure.line.name ?? "Unknown Line"
              ) .multilineTextAlignment(.leading).font(
                 .system(size: TextSizes.body)
             ).foregroundStyle(.secondary)
        }.frame(maxWidth: .infinity, alignment: .leading)
        HStack {
            DestinationIcon().stroke(
                style: StrokeStyle(
                    lineWidth: 1,
                    lineCap: .round,
                    lineJoin: .round,
                )
            ).frame(width: 20, height: 20)
            Text(
                "\(departure.line.transitLineFinalDestination ?? "Unknown Destination")"
            )
            .multilineTextAlignment(.leading).font(
             .system(size: TextSizes.body)
            ).foregroundStyle(.secondary)
        }.frame(maxWidth: .infinity, alignment: .leading)
        HStack {
            PlatformIcon().stroke(
                style: StrokeStyle(
                    lineWidth: 1,
                    lineCap: .round,
                    lineJoin: .round,
                )
            ).frame(width: 20, height: 20)
            Text(
                "\(departure.platform ?? "Platform Unknown")"
            )
            .multilineTextAlignment(.leading).font(
             .system(size: TextSizes.body)
            ).foregroundStyle(.secondary)
        }.frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    struct DepartureCardPreviewWrapper: View {
        @StateObject var routeResultsViewModel = DeparturesViewModel(
            forPreview: true
        )
        var body: some View {
            if let firstStation = routeResultsViewModel.departures.first {
               if let firstDeparture = firstStation.departures.first {
                    Departure(departure: firstDeparture)
                } else {
                    Text("No Departures Available")
                }
            } else {
                Text("No Departure Data")
            }
        }
    }
    return DepartureCardPreviewWrapper()
}
