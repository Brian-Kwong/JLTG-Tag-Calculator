//
//  RouteDetails.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/6/25.
//

import SwiftUI

func determineCostAfterStep(route: RouteResponse, startingBalance: Int = 2000)
    -> [Int]
{
    var balance = startingBalance
    var balanceAfterStep: [Int] = []
    for step in route.steps {
        balance -= step.journeyCost
        balanceAfterStep.append(balance)
    }
    return balanceAfterStep
}


struct RouteDetails: View {
    @Binding var userBalance: Int
    let route: RouteResponse
    @State private var showMap : Bool = false
    var body: some View {
        let balanceAfterStep = determineCostAfterStep(
            route: route,
            startingBalance: userBalance
        )
        VStack {
            RouteCard(route: route).padding(.bottom, 12)
            List(route.steps.indices, id: \.self) { idx in
                let step = route.steps[idx]
                let balance = balanceAfterStep[idx]
                RouteStep(routeStep: step, balance: balance)
            }
        }.listStyle(.plain).padding(.horizontal, 12).toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showMap.toggle()
                }) {
                    Image(systemName: "map")
                }
            }
        }.navigationTitle("Route Details").navigationDestination(
            isPresented: $showMap
        ){
            RouteMap(route: route)
        }
    }
}

#Preview {
    struct RouteDetailsPreviewWrapper: View {
        @StateObject var routeResultsViewModel = RoutesViewModel(
            forPreview: true
        )
        @State private var userBalance: Int = 2000
        var body: some View {
            if let firstRoute = routeResultsViewModel.routes.first {
                RouteDetails(userBalance: $userBalance, route: firstRoute)
            } else {
                Text("No Route Data")
            }
        }
    }
    return RouteDetailsPreviewWrapper()
}
