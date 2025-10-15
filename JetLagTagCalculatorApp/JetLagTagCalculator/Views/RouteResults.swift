//
//  RouteResults.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/5/25.
//

import SwiftUI

struct RouteResults: View {
    @ObservedObject var routeResultsViewModel: RoutesViewModel

    @State var searched: Bool = false
    var body: some View {
        Group {
            if routeResultsViewModel.isLoading {
                VStack {
                    ProgressView()
                    Text("Fetching routes...")
                }
            } else if !routeResultsViewModel.routes.isEmpty {
                List(routeResultsViewModel.routes) { route in
                    HStack {
                        RouteCard(route: route)
                            .background(
                                NavigationLink(value: route) {
                                    EmptyView()
                                }.opacity(0)
                            ).padding(.vertical, 24)
                    }.frame(maxWidth: .infinity, alignment: .center)
                        .listRowInsets(EdgeInsets())
                }
                .listStyle(.plain)
            } else if routeResultsViewModel.errorMessage != nil {
                VStack(alignment: .center, spacing: 12) {
                    Image(
                        systemName: routeResultsViewModel.errorIcon
                            ?? "exclamationmark.triangle"
                    )
                    .font(.system(size: 48))
                    .foregroundColor(.red)
                    Text(" \(routeResultsViewModel.errorMessage!)")
                        .multilineTextAlignment(.center)
                }.containerRelativeFrame(
                    .horizontal,
                    count: 2,
                    span: 1,
                    spacing: 1,
                    alignment: .center
                )
            } else {
                VStack {
                    Text("No routes found")
                }
            }
        }
        .navigationDestination(for: RouteResponse.self) { route in
            RouteDetails(
                userBalance: $routeResultsViewModel.userBalance,
                route: route
            )
        }.toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                SortByButton(
                    selectedSortOption: $routeResultsViewModel.sortByOption
                )
            }
        }.refreshable {
            routeResultsViewModel.refresh()
        }
        .alert("Low Balance", isPresented: $routeResultsViewModel.lowBalanceWarningShown) {
            Button("Go Back") {
                routeResultsViewModel.lowBalanceWarningShown = false
                routeResultsViewModel.showRouteDetails = false
            }
            Button("Continue") {
                routeResultsViewModel.lowBalanceWarningShown = false
            }
        } message: {
            Text(
                "You currently do not have the coin budget to reach your destination."
            )
        }
    }
}

#Preview {
    struct RouteDetailsPreviewWrapper: View {
        @StateObject var routeResultsViewModel = RoutesViewModel(
            forPreview: true
        )
        var body: some View {
            RouteResults(routeResultsViewModel: routeResultsViewModel)
        }
    }
    return RouteDetailsPreviewWrapper()
}
