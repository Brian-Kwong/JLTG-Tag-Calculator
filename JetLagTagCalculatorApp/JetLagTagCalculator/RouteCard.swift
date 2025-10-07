//
//  RouteCard.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/6/25.
//

import SwiftUI

func determineRouteLargeOcpm(route: RouteResponse) -> AnyView {
    var transportationModeTypeCount: [TransportationModes: Int] = route.steps
        .reduce(
            into: [:]
        ) { counts, step in
            counts[step.transportationMode, default: 0] += 1
        }
    // Set walking as last resort
    transportationModeTypeCount[.WALKING, default: 0] = 0
    let transportationMode =
        transportationModeTypeCount.max {
            a,
            b in
            a.value < b.value
                || (a.value == b.value
                    && TransportationModes.allCases.firstIndex(of: a.key)!
                        > TransportationModes.allCases.firstIndex(of: b.key)!)
        }?.key ?? .LOW_SPEED_RAIL
    var icon: AnyView
    var color: Color
    switch transportationMode {
    case .HIGH_SPEED_RAIL:
        icon = AnyView(HighSpeedTrain())
        color = .blue
    case .LOW_SPEED_RAIL:
        icon = AnyView(LowSpeedRail())
        color = .green
    case .METRO:
        icon = AnyView(MetroTrain())
        color = .orange
    case .BUS:
        icon = AnyView(BusIcon())
        color = .yellow
    case .FERRY:
        icon = AnyView(FerryIcon())
        color = .blue
    case .WALKING:
        icon = AnyView(WalkingIcon())
        color = .pink
    case .FLIGHT:
        icon = AnyView(Airplane())
        color = .purple
    }
    return AnyView(
        icon.frame(
            width: 40,
            height: 40,
            alignment: .center
        ).padding(20).background(color.opacity(0.2)).cornerRadius(50)
    )
}

func findFirstTransitStation(route: RouteResponse) -> String {
    for step in route.steps {
        if step.transportationMode != .WALKING {
            return step.startLocation.name
        }
    }
    return route.departureLocation.name
}

func findLastTransitStation(route: RouteResponse) -> String {
    for step in route.steps.reversed() {
        if step.transportationMode != .WALKING {
            return step.endLocation.name
        }
    }
    return route.arrivalLocation.name
}

struct RouteCard: View {
    let route: RouteResponse
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    var body: some View {
        let isCompact = horizontalSizeClass == .compact
        HStack(spacing: 12) {
            VStack(alignment: .center) {
                Text(convertSecondsToTimeFormat(seconds: route.totalDuration))
                    .font(.system(size: TextSizes.body, weight: .medium))
                determineRouteLargeOcpm(route: route)
                HStack {
                    Coins().stroke(
                        style: StrokeStyle(
                            lineWidth: 1,
                            lineCap: .round,
                            lineJoin: .round
                        )
                    ).frame(width: 20, height: 20)
                    Text(route.totalCost.description).font(
                        .system(size: TextSizes.body, weight: .medium)
                    )
                    .foregroundStyle(.secondary)

                }
            }
            VStack(alignment: .center, spacing: 16) {
                HStack(spacing: 12) {
                    if isCompact{
                        VStack {
                            Text(findFirstTransitStation(route: route))
                                .font(
                                    .system(size: TextSizes.subtitle, weight: .bold)
                                )
                            Text("to")
                                .font(.system(size: TextSizes.caption))
                                .foregroundStyle(
                                    .secondary
                                )
                            Text(findLastTransitStation(route: route))
                                .font(
                                    .system(size: TextSizes.subtitle, weight: .bold)
                                )
                        }
                    } else {
                        HStack {
                            Text(findFirstTransitStation(route: route))
                                .font(
                                    .system(size: TextSizes.subtitle, weight: .bold)
                                )
                            Text("to")
                                .font(.system(size: TextSizes.caption))
                                .foregroundStyle(
                                    .secondary
                                )
                            Text(findLastTransitStation(route: route))
                                .font(
                                    .system(size: TextSizes.subtitle, weight: .bold)
                                )
                        }
                    }
                }
                ViewThatFits {
                    LazyVGrid(
                        columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 4),
                        spacing: 10
                    ) {
                        routeDetailsInfo
                    }  .frame(minWidth: 600, alignment: .center)
                    
                    LazyVGrid(
                        columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 2),
                        spacing: 10
                    ) {
                        routeDetailsInfo
                    }  .frame(minWidth: 250, alignment: .center)
                    
                    LazyVGrid(
                        columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 1),
                        spacing: 10
                    ) {
                        routeDetailsInfo
                    }  .frame(alignment: .center)
                }
            }
        }
        .padding(12)
        .containerRelativeFrame(
                    .horizontal,
                    count: isCompact ? 20 : 6,
                    span: isCompact ? 19: 5,
                    spacing: 1,
                    alignment: isCompact ? .center : .leading
                )
        .background(Color.gray.opacity(0.15).gradient)
        .cornerRadius(16)
        .border(.gray.opacity(0.2), width: 1.5)
        .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
    }
    
    @ViewBuilder
    private var routeDetailsInfo: some View {
        let isCompact = horizontalSizeClass == .compact
        HStack {
            Image(systemName: "airplane.departure")
                .font(.system(size: TextSizes.subtitle))
            Text(
                "\(route.departureDate) \(isCompact ?  "\n" : "") \(route.departureTime.description.prefix(5))"
            )
                .multilineTextAlignment(.leading).font(
                    .system(size: TextSizes.body)
                ).foregroundStyle(.secondary)
        }
        HStack {
            Image(systemName: "mappin.and.ellipse")
                .font(.system(size: TextSizes.subtitle))
            Text("\(route.totalDistance/1000) km")
                .multilineTextAlignment(.leading).font(
                    .system(size: TextSizes.body)
                ).foregroundStyle(.secondary)
        }
        HStack {
            Image(systemName: "airplane.arrival")
                .font(.system(size: TextSizes.subtitle))
            Text("\(route.arrivalDate) \(isCompact ?  "\n" : "") \(route.arrivalTime.description.prefix(5))")
                .multilineTextAlignment(.leading).font(
                    .system(size: TextSizes.body)
                ).foregroundStyle(.secondary)
        }
        HStack {
            TransferIcon()
                .stroke(
                    style: StrokeStyle(
                        lineWidth: 1,
                        lineCap: .round,
                        lineJoin: .round
                    )
                ).frame(width: 24, height: 24)
            Text(route.numTransfers.description + (route.numTransfers == 1 ? " Transfer" : " Transfers"))
                .multilineTextAlignment(.leading).font(
                    .system(size: TextSizes.body)
                ).foregroundStyle(.secondary)
        }
    }
}

#Preview {
    struct RouteCardPreviewWrapper: View {
        @StateObject var routeResultsViewModel = RouteResultsViewModel()
        var body: some View {
            if let firstRoute = routeResultsViewModel.routes.first {
                RouteCard(route: firstRoute)
            } else {
                Text("No Route Data")
            }
        }
    }
    return RouteCardPreviewWrapper()
}
