//
//  RouteCard.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/6/25.
//

import SwiftUI

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
                routeOverview
            }.padding(.horizontal, isCompact ? 0 : 12)
            VStack(alignment: .center, spacing: 16) {
                HStack(spacing: 12) {
                    ViewThatFits {
                        HStack {
                            routeSourceToDestination
                        }
                        VStack {
                            routeSourceToDestination
                        }
                    }
                }
                ViewThatFits {
                    LazyVGrid(
                        columns: Array(
                            repeating: GridItem(.flexible(), spacing: 10),
                            count: 4
                        ),
                        spacing: 10
                    ) {
                        routeDetailsInfo
                    }.frame(minWidth: 600, alignment: .center)

                    LazyVGrid(
                        columns: Array(
                            repeating: GridItem(.flexible(), spacing: 10),
                            count: 2
                        ),
                        spacing: 10
                    ) {
                        routeDetailsInfo
                    }.frame(minWidth: 250, alignment: .center)

                    LazyVGrid(
                        columns: Array(
                            repeating: GridItem(.flexible(), spacing: 10),
                            count: 1
                        ),
                        spacing: 10
                    ) {
                        routeDetailsInfo
                    }.frame(alignment: .center)
                }
            }
        }
        .padding(12)
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
            Image(systemName: "airplane.arrival")
                .font(.system(size: TextSizes.subtitle))
            Text(
                "\(route.arrivalDate) \(isCompact ?  "\n" : "") \(route.arrivalTime.description.prefix(5))"
            )
            .multilineTextAlignment(.leading).font(
                .system(size: TextSizes.body)
            ).foregroundStyle(.secondary)
        }
        HStack {
            Image(systemName: "mappin.and.ellipse")
                .font(.system(size: TextSizes.subtitle))
            Text("\( String(format: "%.2f", route.totalDistance/1000)) km")
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
            Text(
                route.numTransfers.description
                    + (route.numTransfers == 1 ? " Transfer" : " Transfers")
            )
            .multilineTextAlignment(.leading).font(
                .system(size: TextSizes.body)
            ).foregroundStyle(.secondary)
        }
    }

    @ViewBuilder var routeOverview: some View {
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

    @ViewBuilder var routeSourceToDestination: some View {
        Text(findFirstTransitStation(route: route))
            .font(
                .system(
                    size: TextSizes.subtitle,
                    weight: .bold
                )
            )
        Text("to")
            .font(.system(size: TextSizes.caption))
            .foregroundStyle(
                .secondary
            )
        Text(findLastTransitStation(route: route))
            .font(
                .system(
                    size: TextSizes.subtitle,
                    weight: .bold
                )
            )
    }
}

#Preview {
    struct RouteCardPreviewWrapper: View {
        @StateObject var routeResultsViewModel = RoutesViewModel(
            forPreview: true
        )
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
