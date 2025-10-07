//
//  ContentView.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/2/25.
//

import SwiftUI

struct SearchRoute: View {
    var body: some View {
        NavigationSplitView {
            SelectRoutePicker()
        } detail: {
            RouteResults()
        }
    }
}

#Preview {
    SearchRoute()
}
