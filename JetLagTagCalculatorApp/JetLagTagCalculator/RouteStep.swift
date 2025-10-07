//
//  RouteStep.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/5/25.
//

import SwiftUI


func determineRouteLogo(transportationMode: TransportationModes) -> AnyView {
    switch transportationMode {
    case .HIGH_SPEED_RAIL:
        return AnyView(RouteLogo(icon: HighSpeedTrain(), iconColor: .blue))
    case .LOW_SPEED_RAIL:
        return AnyView(RouteLogo(icon: LowSpeedRail(), iconColor: .green))
    case .METRO:
        return AnyView(RouteLogo(icon: MetroTrain(), iconColor: .orange))
    case .BUS:
        return AnyView(RouteLogo(icon: BusIcon(), iconColor: .yellow))
    case .FERRY:
        return AnyView(RouteLogo(icon: FerryIcon(), iconColor: .blue))
    case .WALKING:
        return AnyView(RouteLogo(icon: WalkingIcon(), iconColor: .pink))
    case .FLIGHT:
        return AnyView(RouteLogo(icon: Airplane(), iconColor: .purple))
    }
}

struct RouteStep: View {
    let routeStep: ResponseStep
    let balance: Int = 2000
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text(routeStep.transportationMode.rawValue)
                        .font(.system(size: TextSizes.body, weight: .bold))
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .frame(alignment: .center)
                    determineRouteLogo(
                        transportationMode: routeStep.transportationMode
                    )

                    HStack {
                        VStack(alignment: .leading) {
                            Text(routeStep.startLocation.name)
                                .multilineTextAlignment(.leading).lineLimit(2)
                                .font(
                                    .system(
                                        size: TextSizes.body,
                                        weight: .medium
                                    )
                                )
                            Text(
                                extractTime(
                                    timeString: routeStep.departureTime ?? ""
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
                        }.multilineTextAlignment(.leading).padding(.leading, 20).containerRelativeFrame(
                            .horizontal,
                            count: 3,
                            span: 1,
                            spacing: 1,
                            alignment: .leading
                        )
                        VStack(alignment: .center) {
                            if let lineName = routeStep.lineNam {
                                Text(lineName)
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
                            .multilineTextAlignment(.center)

                        }.containerRelativeFrame(
                            .horizontal,
                            count: 3,
                            span: 1,
                            spacing: 1,
                            alignment: .center
                        )
                        VStack(alignment: .trailing) {
                            Text(routeStep.endLocation.name)
                                .multilineTextAlignment(.trailing).lineLimit(2)
                                .font(
                                    .system(
                                        size: TextSizes.body,
                                        weight: .medium
                                    )
                                )
                            Text(
                                extractTime(
                                    timeString: routeStep.arrivalTime ?? ""
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

                        }.multilineTextAlignment(.trailing).padding(.trailing, 20).containerRelativeFrame(
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
                    Text("\(balance - routeStep.journeyCost)")
                        .font(.system(size: TextSizes.body, weight: .medium))
                        .foregroundStyle(.secondary)
                }

            }
        }.padding(12)
            .frame(maxWidth: .infinity, alignment: .top)
            .cornerRadius(8)

    }
}

#Preview {
    struct RouteStepPreviewWrapper: View {
        @StateObject var routeResultsViewModel = RouteResultsViewModel()
        var body: some View {
            if let firstRoute = routeResultsViewModel.routes.first {
                let firstLeg = firstRoute.steps.first
                RouteStep(routeStep: firstLeg!)
            } else {
                Text("No Route Data")
            }
        }
    }
    return RouteStepPreviewWrapper()
}
