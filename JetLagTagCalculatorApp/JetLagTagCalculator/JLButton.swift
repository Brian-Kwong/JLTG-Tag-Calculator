//
//  JLButton.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/2/25.
//

import SwiftUI

struct JLButton: View {
    var isPrimary: Bool = true
    var title: String = "Button"
    var icon: String = "plus"
    @State var isPressed: Bool = false
    let action: () -> Void = {}
    var body: some View {
        buttonMain
    }

    @ViewBuilder
    private var buttonMain: some View {
        if isPrimary {
            Button(action: action) {
                Label(title, systemImage: icon).containerRelativeFrame(
                    .horizontal,
                    count: 2,
                    span: 1,
                    spacing: 1,
                    alignment: .center
                )
            }
            .buttonStyle(.glassProminent)
        } else {
            Button(action: action) {
                Label(title, systemImage: icon)
            }
            .buttonStyle(.glass)
        }

    }
}

#Preview {
    VStack {
        JLButton()
        JLButton(isPrimary: false)
    }
}
