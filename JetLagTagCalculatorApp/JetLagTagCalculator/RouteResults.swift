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
        if searched {
            if routeResultsViewModel.isLoading {
                ProgressView("Fetching Routes...")
                    .progressViewStyle(.circular)
                    .scaleEffect(1.5)
            }
            else if routeResultsViewModel.routes.isEmpty {
                VStack {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.system(size: 64))
                        .padding()
                    Text("No Routes Found")
                }
            } else {
                Text("Routes Found: \(routeResultsViewModel.routes.count)")
            }
        } else {
            VStack {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 64))
                    .padding()
                Text("No Search Initaiated")
            }
        }
    }
}

#Preview {
    RouteResults()
}
