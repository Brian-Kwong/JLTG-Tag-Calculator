//
//  RouteStep.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/5/25.
//

import SwiftUI

struct RouteStep: View {
    let routeStep: ResponseStep
    let balance: Int
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text(
                        routeStep.transportationMode.rawValue
                            .replacingOccurrences(of: "_", with: " ")
                            .localizedCapitalized
                    )
                    .font(.system(size: TextSizes.body, weight: .bold))
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .frame(alignment: .center)
                    determineRouteLogo(
                        transportationMode: routeStep.transportationMode
                    )

                    HStack {
                        VStack(alignment: .leading) {
                            stepLocationAndTimeInfo(
                                location: routeStep.startLocation,
                                time: routeStep
                                    .departureTime
                            )
                        }.multilineTextAlignment(.leading).padding(.leading, 20)
                            .containerRelativeFrame(
                                .horizontal,
                                count: 3,
                                span: 1,
                                spacing: 1,
                                alignment: .leading
                            )
                        VStack(alignment: .center) {
                            if let lineName = routeStep.lineName {
                                Text(
                                    lineName.localizedCapitalized
                                )
                                .font(
                                    .system(
                                        size: TextSizes.body,
                                        weight: .bold
                                    )
                                ).lineLimit(3)
                            } else if let vehicleName = routeStep.vehicleType {
                                Text(
                                    vehicleName.localizedCapitalized
                                )
                                .font(
                                    .system(
                                        size: TextSizes.body,
                                        weight: .bold
                                    )
                                )
                            }
                            Text(
                                "towards \( routeStep.transitLineFinalDestination ?? routeStep.endLocation.name)"
                            )
                            .font(
                                .system(
                                    size: TextSizes.caption,
                                    weight: .medium
                                )
                            )
                            .foregroundStyle(.secondary)

                        }.multilineTextAlignment(.center)
                            .containerRelativeFrame(
                                .horizontal,
                                count: 3,
                                span: 1,
                                spacing: 1,
                                alignment: .center
                            )
                        VStack(alignment: .trailing) {
                            stepLocationAndTimeInfo(
                                location: routeStep.endLocation,
                                time: routeStep.arrivalTime
                            )
                        }.multilineTextAlignment(.trailing).padding(
                            .trailing,
                            20
                        ).containerRelativeFrame(
                            .horizontal,
                            count: 3,
                            span: 1,
                            spacing: 1,
                            alignment: .trailing
                        )
                    }
                }
            }.padding(12)
            HStack(alignment: .center, spacing: 20) {
                HStack {
                    Image(systemName: "clock")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                    Text(
                        convertSecondsToTimeFormat(seconds: routeStep.duration)
                    )
                    .font(.system(size: TextSizes.body, weight: .medium))
                    .foregroundStyle(.secondary)
                }
                HStack {
                    Coins().stroke(
                        style: StrokeStyle(
                            lineWidth: 1.5,
                            lineCap: .round,
                            lineJoin: .round,
                        )
                    ).frame(width: 20, height: 20)
                    Text(routeStep.journeyCost.description)
                        .font(.system(size: TextSizes.body, weight: .medium))
                        .foregroundStyle(.secondary)
                }
                HStack {
                    Image(systemName: "wallet.bifold")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                    Text("\(balance)")
                        .font(.system(size: TextSizes.body, weight: .medium))
                        .foregroundStyle(.secondary)
                }

            }
        }.padding(12)
            .frame(maxWidth: .infinity, alignment: .top)
            .cornerRadius(8)
    }

    @ViewBuilder
    private func stepLocationAndTimeInfo(location: Location, time: String?)
        -> some View
    {
        Text(location.name)
            .multilineTextAlignment(.leading).lineLimit(2)
            .font(
                .system(
                    size: TextSizes.body,
                    weight: .medium
                )
            )
        Text(
            extractTime(
                timeString: time ?? ""
            )
        )
        .font(
            .system(
                size: TextSizes.body,
                weight: .medium
            )
        )
        .foregroundStyle(
            .secondary
        )
    }
}

#Preview {
    struct RouteStepPreviewWrapper: View {
        @StateObject var routeResultsViewModel = RoutesViewModel(
            forPreview: true
        )
        var body: some View {
            if let firstRoute = routeResultsViewModel.routes.first {
                let firstLeg = firstRoute.steps.first
                RouteStep(routeStep: firstLeg!, balance: 100)
            } else {
                Text("No Route Data")
            }
        }
    }
    return RouteStepPreviewWrapper()
}
