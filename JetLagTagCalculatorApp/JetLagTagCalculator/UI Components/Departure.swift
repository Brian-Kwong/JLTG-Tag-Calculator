//
//  Departure.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/14/25.
//

import SwiftUI

struct Departure: View, Equatable {
    let departure: RouteDeparture
    let statusColorMapping: [String: Color] = [
        "On Time": .green,
        "Scheduled": .green,
        "Delayed": .yellow,
        "Cancelled": .red,
        "Additional": .blue,
        "Replaced": .orange,
        "Unknown": .gray,
    ]
    @State var departureStatus: String

    init(departure: RouteDeparture) {
        self.departure = departure
        self.departureStatus =
            departure.status != nil
            ? departure.status!.capitalized
            : departure.delay != nil && departure.delay! > 0
                ? "Delayed" : "On Time"
    }

    static func == (lhs: Departure, rhs: Departure) -> Bool {
        lhs.departure == rhs.departure
    }

    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    var body: some View {
        let isCompact = horizontalSizeClass == .compact
        HStack(alignment: .center, spacing: 12) {
            createIcon(
                transportationMode: departure.line.mode,
                iconSize: 28,
                iconPadding: 8
            )
            ViewThatFits {
                LazyVGrid(
                    columns: Array(
                        repeating: GridItem(.flexible(), spacing: 8),
                        count: 4
                    ),
                    spacing: 10
                ) {
                    departureInfo
                }.frame(
                    minWidth: 600,
                    minHeight: 40,
                    alignment: .center
                )
                LazyVGrid(
                    columns: Array(
                        repeating: GridItem(.flexible(), spacing: 8),
                        count: 2
                    ),
                    spacing: 10
                ) {
                    departureInfo
                }.frame(minWidth: 250, minHeight: 80, alignment: .center)
                LazyVGrid(
                    columns: Array(
                        repeating: GridItem(.flexible(), spacing: 8),
                        count: 1
                    ),
                ) {
                    departureInfo
                }.frame(minHeight: 140, alignment: .leading).padding(.leading, 4)
            }
        }.padding(12)
            .containerRelativeFrame(
                .horizontal,
                count: isCompact ? 20 : 6,
                span: isCompact ? 19 : 5,
                spacing: 1,
                alignment: isCompact ? .leading : .leading
            )
            .cornerRadius(16)
    }

    @ViewBuilder
    private var departureInfo: some View {
        let daysAhead = calculateDaysAhead(date: departure.time)
        HStack {
            Image(systemName: "clock.badge")
                .frame(width: 20, height: 20)
            Text(
                "\(extractTime(timeString: departure.time))"
                    + (daysAhead > 0
                        ? " (+\(daysAhead) day\(daysAhead > 1 ? "s" : ""))"
                        : "")
            )
            .multilineTextAlignment(.leading).font(
                .system(size: TextSizes.body)
            ).foregroundStyle(.secondary)
            Text(
                departureStatus == "Delayed"
                    ? "Delayed +\(convertSecondsToTimeFormat(seconds: departure.delay!))"
                    : departureStatus
            ).multilineTextAlignment(.center)
                .font(.system(size: TextSizes.smallCaption))
                .padding(.horizontal, 4)
                .background(
                    statusColorMapping[
                        departureStatus
                    ]?.opacity(0.15) ?? Color.green.opacity(0.2)
                )
                .cornerRadius(50)
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
            ).multilineTextAlignment(.leading).font(
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
                "\(departure.platform ?? "Platform\nUnknown")"
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
