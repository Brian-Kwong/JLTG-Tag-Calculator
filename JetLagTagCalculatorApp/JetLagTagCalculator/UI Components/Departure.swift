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
        HStack(spacing: 24){
           createIcon(
            transportationMode: departure.line.mode,
                iconSize: isCompact
                ? 30 : 40,
               iconPadding: isCompact
               ? 10 : 20)
           HStack(spacing: 16){
               departureInfo
           }
        }
    }
    
    @ViewBuilder
    private var departureInfo: some View {
        HStack {
            Image(systemName: "clock.badge")
                .frame(width: 16, height: 16)
            Text(
             extractTime(timeString: departure.time)
            )
             .multilineTextAlignment(.leading).font(
                 .system(size: TextSizes.body)
             ).foregroundStyle(.secondary)
        }
        HStack {
            Circle()
                .foregroundStyle(
                 Color(
                     hexString: departure.line.color ?? "000000"
                 ) ?? .black
                )
                .frame(width: 16, height: 16)
            Text(
             departure.line.name ?? "Unknown Line"
              ) .multilineTextAlignment(.leading).font(
                 .system(size: TextSizes.body)
             ).foregroundStyle(.secondary)
        }
        HStack {
            DestinationIcon().stroke(
                style: StrokeStyle(
                    lineWidth: 1,
                    lineCap: .round,
                    lineJoin: .round,
                )
            ).frame(width: 28, height: 28)
            Text(
                "\(departure.line.transitLineFinalDestination ?? "Unknown Destination")"
            )
            .multilineTextAlignment(.leading).font(
             .system(size: TextSizes.body)
            ).foregroundStyle(.secondary)
        }
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
