//
//  RouteResults.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/5/25.
//

import SwiftUI

struct RouteResults: View {
    @StateObject var routeResultsViewModel = RouteResultsViewModel()
    @State var searched: Bool = true
    var body: some View {
        NavigationStack {
            if !routeResultsViewModel.routes.isEmpty {
                List(routeResultsViewModel.routes) { route in
                    HStack {
                        Spacer()
                        RouteCard(route: route)
                        Spacer()
                    }
                }.listStyle(.plain)
            } else {
                VStack {
                    Text("No routes found")
                        .font(.system(size: TextSizes.title))
                        .padding()
                }
            }
        }
    }
}

#Preview {
    RouteResults()
}
