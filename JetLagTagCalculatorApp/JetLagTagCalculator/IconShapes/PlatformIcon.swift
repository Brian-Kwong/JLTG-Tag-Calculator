//
//  PlatformIcon.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/15/25.
//

import SwiftUI

struct PlatformIcon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0, y: 0.96536*height))
        path.addLine(to: CGPoint(x: width, y: 0.96536*height))
        path.move(to: CGPoint(x: 0.35882*width, y: 0.33411*height))
        path.addLine(to: CGPoint(x: 0.65294*width, y: 0.33411*height))
        path.addLine(to: CGPoint(x: 0.65294*width, y: 0.89661*height))
        path.addLine(to: CGPoint(x: 0.35882*width, y: 0.89661*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.02353*width, y: 0.57786*height))
        path.addLine(to: CGPoint(x: 0.32941*width, y: 0.57786*height))
        path.addLine(to: CGPoint(x: 0.32941*width, y: 0.96536*height))
        path.addLine(to: CGPoint(x: 0.02353*width, y: 0.96536*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.68235*width, y: 0.57786*height))
        path.addLine(to: CGPoint(x: 0.95294*width, y: 0.57786*height))
        path.addLine(to: CGPoint(x: 0.95294*width, y: 0.96536*height))
        path.addLine(to: CGPoint(x: 0.68235*width, y: 0.96536*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.23529*width, y: 0.17788*height))
        path.addLine(to: CGPoint(x: 0.97647*width, y: 0.17788*height))
        path.addLine(to: CGPoint(x: 0.97647*width, y: 0.92788*height))
        path.addLine(to: CGPoint(x: 0.02353*width, y: 0.92788*height))
        path.addLine(to: CGPoint(x: 0.02353*width, y: 0.40288*height))
        path.addCurve(to: CGPoint(x: 0.23529*width, y: 0.17788*height), control1: CGPoint(x: 0.02353*width, y: 0.2786*height), control2: CGPoint(x: 0.11834*width, y: 0.17788*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.27059*width, y: 0.12786*height))
        path.addLine(to: CGPoint(x: 0.72941*width, y: 0.12786*height))
        path.addLine(to: CGPoint(x: 0.72941*width, y: 0.15286*height))
        path.addLine(to: CGPoint(x: 0.27059*width, y: 0.15286*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.36905*width, y: 0.16249*height))
        path.addLine(to: CGPoint(x: 0.65721*width, y: 0.02049*height))
        path.move(to: CGPoint(x: 0.4*width, y: 0.02161*height))
        path.addLine(to: CGPoint(x: 0.69412*width, y: 0.02161*height))
        return path
    }
}
