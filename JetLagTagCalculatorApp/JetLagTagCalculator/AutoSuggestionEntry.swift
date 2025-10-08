//
//  AutoSuggestionEntry.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/4/25.
//

import GooglePlacesSwift
import SwiftUI

func findIcon(for place: AutocompletePlaceSuggestion) -> String {
    for placeType in place.types {
        switch placeType.rawValue {
        case "city_hall":
            return "building.2.fill"
        case "airport", "international_airport", "airstrip":
            return "airplane.departure"
        case "train_station", "subway_station", "light_rail_station":
            return "tram.fill"
        case "bus_station", "bus_stop":
            return "bus.fill"
        case "taxi_stand":
            return "car.fill"
        case "ferry_terminal":
            return "ferry.fill"
        default:
            continue
        }
    }
    return "mappin.and.ellipse"
}

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
