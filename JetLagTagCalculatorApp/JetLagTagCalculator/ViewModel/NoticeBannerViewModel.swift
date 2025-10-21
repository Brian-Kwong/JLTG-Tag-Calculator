//
//  NoticeBannerViewModel.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/20/25.
//

import Foundation
internal import Combine
internal import CoreGraphics
import SwiftUI

class NoticeBannerViewModel: ObservableObject {
    @Published var isAnimating = false
    @Published var dragOffset = CGSize.zero
    @Published var isVisible = false {
        didSet {
            withAnimation {
                isAnimating = isVisible
            }
        }
    }
    let maxDragOffsetHeight: CGFloat = -50.0
    
    func setBannerVisibility(_ visible: Bool) {
        withAnimation {
            isVisible = visible
            if !visible {
                dragOffset = .zero
                isAnimating = false
            }
        }
    }
}

