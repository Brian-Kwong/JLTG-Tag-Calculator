//
//  SortByButton.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/7/25.
//

import SwiftUI

struct SortByButton<OpitionType>: View
where
    OpitionType: CaseIterable & Hashable
        & RawRepresentable, OpitionType.RawValue == String
{
    @Binding var selectedSortOption: OpitionType
    var body: some View {
        Menu {
            Label("Sort By", systemImage: "arrow.2.circlepath.circle")
            Divider()
            Picker("Sort By", selection: $selectedSortOption) {
                ForEach(Array(OpitionType.allCases), id: \.self) { option in
                    Label(
                        String(describing: option).titleCase(),
                        systemImage: option.rawValue
                    )
                    .tag(option)
                }
            }
        } label: {
            Button(action: {}) {
                Label("Sort By", systemImage: "arrow.2.circlepath.circle")
            }
        }
    }
}

extension String {
    public func titleCase() -> String {
        return
            self
            .replacingOccurrences(
                of: "([A-Z])",
                with: " $1",
                options: .regularExpression,
                range: range(of: self)
            )
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .capitalized  // If input is in llamaCase
    }

}
