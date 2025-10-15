//
//  TrainLine.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/14/25.
//

import Foundation
import SwiftUI

struct TrainLine: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.addEllipse(in: CGRect(x: 0.00998*width, y: 0.68891*height, width: 0.28072*width, height: 0.29784*height))
        path.addEllipse(in: CGRect(x: 0.68971*width, y: 0.01016*height, width: 0.30071*width, height: 0.31905*height))
        path.move(to: CGPoint(x: 0.25353*width, y: 0.75641*height))
        path.addLine(to: CGPoint(x: 0.71334*width, y: 0.26856*height))
        return path
    }
}
