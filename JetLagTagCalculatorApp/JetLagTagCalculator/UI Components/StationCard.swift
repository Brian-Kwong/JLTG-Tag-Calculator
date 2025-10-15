//
//  StationCard.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/14/25.
//

import SwiftUI

struct StationCard: View {
    let station : RouteDeparturesResponse
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    var body: some View {
        let isCompact = horizontalSizeClass == .compact
        HStack{
            createIcon(
                transportationMode: station.station.type,
                iconPadding: isCompact
                ? 10 : 20)
            VStack{
                Text(station.station.name)
                    .font(.system(size: TextSizes.subtitle, weight: .bold))
                    .foregroundStyle(.primary)
                    .multilineTextAlignment(.leading)
                HStack{
                    HStack {
                        Image(systemName: "mappin.and.ellipse")
                            .font(.system(size: TextSizes.subtitle))
                        Text(
                            "\( String(format: "%.2f", (station.station.distance ?? 0)/1000))\nkm"
                        )
                            .multilineTextAlignment(.leading).font(
                                .system(size: TextSizes.body)
                            ).foregroundStyle(.secondary)
                    }
                    HStack {
                        TrainLine().stroke(
                            style: StrokeStyle(
                                lineWidth: 1,
                                lineCap: .round,
                                lineJoin: .round,
                            )
                        ).frame(width: 25, height: 25)
                        Text(
                            "\(station.numberOfLines)\nLines"
                        )
                            .multilineTextAlignment(.leading).font(
                                .system(size: TextSizes.body)
                            ).foregroundStyle(.secondary)
                    }
                    HStack {
                        DepartureTrainIcon().stroke(
                            style: StrokeStyle(
                                lineWidth: 1,
                                lineCap: .round,
                                lineJoin: .round,
                            )
                        ).frame(width: 25, height: 25)
                        Text(
                            "\(station.departures.count) \nDepartures"
                        )
                            .multilineTextAlignment(.leading).font(
                                .system(size: TextSizes.body)
                            ).foregroundStyle(.secondary)
                    }
                }
            }
        }        .padding(12)
            .containerRelativeFrame(
                .horizontal,
                count: isCompact ? 20 : 6,
                span: isCompact ? 19 : 5,
                spacing: 1,
                alignment: isCompact ? .center : .leading
            )
            .background(Color.gray.opacity(0.15).gradient)
            .cornerRadius(16)
            .border(.gray.opacity(0.2), width: 1.5)
            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
    }
}

#Preview {
    struct StationCardPreviewWrapper: View {
        @StateObject var routeResultsViewModel = DeparturesViewModel(
            forPreview: true
        )
        var body: some View {
            if let firstStation = routeResultsViewModel.departures.first {
                StationCard(station : firstStation)
            } else {
                Text("No Departure Data")
            }
        }
    }
    return StationCardPreviewWrapper()
}
