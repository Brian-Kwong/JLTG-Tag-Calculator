//
//  RouteDetails.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/6/25.
//

import SwiftUI

func determineCostAfterStep (route : RouteResponse, startingBalance: Int = 2000) -> [Int] {
    var balance = startingBalance
    var balanceAfterStep : [Int] = []
    for step in route.steps {
        balance -= step.journeyCost
        balanceAfterStep.append(balance)
    }
    return balanceAfterStep
}

struct RouteDetails: View {
    let route: RouteResponse
    var body: some View {
        let balanceAfterStep = determineCostAfterStep(route: route)
        VStack {
            Text("Route Details")
                .font(.system(size: TextSizes.title))
            RouteCard(route: route).padding(.bottom, 12)
            List(route.steps.indices, id: \.self) { idx in
                let step = route.steps[idx]
                let balance = balanceAfterStep[idx]
                RouteStep(routeStep: step, balance: balance)
            }
        }.listStyle(.plain)
    }
}

#Preview {
    struct RouteDetailsPreviewWrapper: View {
        @StateObject var routeResultsViewModel = RoutesViewModel(
            forPreview: true
        )
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
