//
//  NavOverlay.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/17/25.
//

import SwiftUI

struct NavOverlay: View {
    @FocusState.Binding var inputFocused: Bool
    @ObservedObject var googlePlacesViewModel : GooglePlacesViewModel
    @Binding var userLocation: UserPlaceEntry
    var overlayOffsetY: CGFloat
    var body: some View {
        if (inputFocused
            && !googlePlacesViewModel.autoCompleteStations.isEmpty
            && userLocation.location != "")
        {
            VStack {
                ForEach(
                    googlePlacesViewModel.autoCompleteStations
                        .prefix(5),
                    id: \.self
                ) { suggestion in
                    AutoSuggestionEntry(
                        suggestion: suggestion,
                        userInput: $userLocation,
                        inputFocused: $inputFocused,
                    )
                }
            }.frame(maxWidth: .infinity)
                .background(.ultraThinMaterial)
                .cornerRadius(8)
                .padding()
                .shadow(radius: 5)
                .offset(y: overlayOffsetY)
        }
    }
}
