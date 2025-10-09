//
//  RouteResults.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/5/25.
//

import SwiftUI

struct RouteResults: View {
    @StateObject var routeResultsViewModel = RouteResultsViewModel(
        orgin: nil,
        destination: nil
    )
    @State var searched: Bool = true
    var body: some View {
        NavigationStack {
            Group {
                if !routeResultsViewModel.routes.isEmpty {
                        List(routeResultsViewModel.routes) { route in
                            HStack{
                                RouteCard(route: route)
                                    .background(
                                        NavigationLink(value: route) { EmptyView()
                                        }.opacity(0)).padding(.vertical, 24)
                            }.frame(maxWidth: .infinity, alignment: .center)
                                .listRowInsets(EdgeInsets())
                        }
                        .listStyle(.plain)
                } else {
                    VStack {
                        Text("No routes found")
                    }
                }
            }
            .navigationDestination(for: RouteResponse.self) { route in
                RouteDetails(route: route)
            }.toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    SortByButton(
                        selectedSortOption: $routeResultsViewModel.sortByOption
                    )
                }
            }
        }
    }
}

#Preview {
    RouteResults()
}
