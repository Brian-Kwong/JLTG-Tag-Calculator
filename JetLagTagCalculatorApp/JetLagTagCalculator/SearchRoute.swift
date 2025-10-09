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
            RouteResults(routeResultsViewModel: routeSearchViewModel)
        }
    }
}

#Preview {
    SearchRoute()
}
