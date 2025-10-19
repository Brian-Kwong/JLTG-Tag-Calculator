//
//  BlurEffect.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/18/25.
//

import SwiftUI

struct ListScrollEffect: ViewModifier {

    func body(content: Content) -> some View {
        content.visualEffect {
            content,
            proxy in

            let frame = proxy.frame(in: .global)
            let cardTop = frame.minY
            let topThreshold: CGFloat = 100
            let bottomThreshold: CGFloat = 700
            let progress =
                min(
                    max(
                        (cardTop - topThreshold)
                            / (bottomThreshold
                                - topThreshold),
                        0
                    ),
                    1
                )

            let scale = 1.0 - (progress * 0.1)

            let blurScale = progress * 0.75

            return
                content
                .scaleEffect(scale)
                .blur(radius: blurScale)
        }
    }
}

extension View {
    func listScrollEffect() -> some View {
        self.modifier(ListScrollEffect())
    }
}
