//
//  SortByButton.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/7/25.
//

import SwiftUI

enum SortByOptions {
    case duration
    case transfers
    case departureTime
    case arrivalTime
    case cost
    case distance
}

struct SortByButton: View {
    @Binding var selectedSortOption: SortByOptions
    var body: some View {
        Menu {
            Label("Sort By", systemImage: "arrow.2.circlepath.circle")
            Divider()
            Picker ("Sort By", selection: $selectedSortOption) {
                Label(
                    "Duration",
                    systemImage: "clock"
                ).tag(SortByOptions.duration)
                Label("Transfers", systemImage: "arrow.triangle.2.circlepath").tag(SortByOptions.transfers)
                Label("Departure Time", systemImage: "arrow.right.circle").tag(SortByOptions.departureTime)
                Label("Arrival Time", systemImage: "arrow.left.circle").tag(SortByOptions.arrivalTime)
                Label("Cost", systemImage: "tram.card").tag(SortByOptions.cost)
                Label("Distance", systemImage: "mappin.and.ellipse").tag(SortByOptions.distance)
            }

        } label: {
            Button(action: {}) {
                Label("Sort By", systemImage: "arrow.2.circlepath.circle")
            }
        }
    }
}

#Preview {
    SortByButton(selectedSortOption: .constant(SortByOptions.duration))
}
