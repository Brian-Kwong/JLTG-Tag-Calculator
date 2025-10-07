//
//  RouteDetails.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/6/25.
//

import SwiftUI

struct RouteDetails: View {
    let route: RouteResponse
    var body: some View {
        VStack{
            Text("Route Details")
                .font(.system(size: TextSizes.title))
            RouteCard(route: route).padding(.bottom, 10)
            List(route.steps) { step in
                RouteStep(routeStep: step)
            }.listStyle(.plain)
        }
    }
}

#Preview {
    struct RouteDetailsPreviewWrapper: View {
        @StateObject var routeResultsViewModel = RouteResultsViewModel()
        var body: some View {
            if let firstRoute = routeResultsViewModel.routes.first {
                RouteDetails(route: firstRoute)
            } else {
                Text("No Route Data")
            }
        }
    }
    return RouteDetailsPreviewWrapper()
}
