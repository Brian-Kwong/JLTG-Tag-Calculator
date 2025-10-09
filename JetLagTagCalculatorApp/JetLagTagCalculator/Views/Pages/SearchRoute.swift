//
//  ContentView.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/2/25.
//

import SwiftUI

struct SearchRoute: View {
    @State private var routeSearchViewModel: RoutesViewModel = RoutesViewModel()
    var body: some View {
        NavigationSplitView {
            SelectRoutePicker(routeResultsViewModel: routeSearchViewModel)
        } detail: {
            NavigationStack {
                if routeSearchViewModel.showRouteDetails {
                    RouteResults(routeResultsViewModel: routeSearchViewModel)
                } else {
                    Text("Please enter route details to search for routes.")
                        .font(.system(size: TextSizes.body))
                        .foregroundColor(.gray)
                }
            }
        }
    }
}

#Preview {
    SearchRoute()
}
