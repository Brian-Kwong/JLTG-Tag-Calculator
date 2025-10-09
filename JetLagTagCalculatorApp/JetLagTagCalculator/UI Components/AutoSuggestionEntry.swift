//
//  AutoSuggestionEntry.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/4/25.
//

import GooglePlacesSwift
import SwiftUI

struct AutoSuggestionEntry: View {
    let suggestion: AutocompletePlaceSuggestion
    @Binding var userInput: UserPlaceEntry
    @FocusState.Binding var inputFocused: Bool
    var body: some View {
        Label(
            "\(suggestion.attributedFullText)",
            systemImage: findIcon(for: suggestion)
        )
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .contentShape(Rectangle())
        .onTapGesture {
            userInput.location = String(
                suggestion.attributedPrimaryText.characters
            )
            userInput.placeID = suggestion.placeID
            inputFocused = false
        }
        Divider()
    }
}
