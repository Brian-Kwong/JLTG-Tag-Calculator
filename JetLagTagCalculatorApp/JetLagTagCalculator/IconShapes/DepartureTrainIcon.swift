//
//  DepartureTrainIcon.swift
//  Icon Provided by Streamline Icons (https://streamlineicons.com)
//  Converted using SVG-to-SwiftUI https://svg-to-swiftui.quassum.com/
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/14/25.
//

import Foundation
import SwiftUI

struct DepartureTrainIcon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0, y: 0))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.66667*width, y: 0.04167*height))
        path.addCurve(to: CGPoint(x: 0.42583*width, y: 0.16875*height), control1: CGPoint(x: 0.56667*width, y: 0.04167*height), control2: CGPoint(x: 0.47833*width, y: 0.09208*height))
        path.addCurve(to: CGPoint(x: 0.42667*width, y: 0.1675*height), control1: CGPoint(x: 0.42625*width, y: 0.16833*height), control2: CGPoint(x: 0.42625*width, y: 0.16792*height))
        path.addCurve(to: CGPoint(x: 0.375*width, y: 0.16667*height), control1: CGPoint(x: 0.41*width, y: 0.16667*height), control2: CGPoint(x: 0.3925*width, y: 0.16667*height))
        path.addCurve(to: CGPoint(x: 0.04167*width, y: 0.33333*height), control1: CGPoint(x: 0.19083*width, y: 0.16667*height), control2: CGPoint(x: 0.04167*width, y: 0.1875*height))
        path.addLine(to: CGPoint(x: 0.04167*width, y: 0.75*height))
        path.addCurve(to: CGPoint(x: 0.08333*width, y: 0.8425*height), control1: CGPoint(x: 0.04167*width, y: 0.78667*height), control2: CGPoint(x: 0.05792*width, y: 0.81958*height))
        path.addLine(to: CGPoint(x: 0.08333*width, y: 0.91667*height))
        path.addCurve(to: CGPoint(x: 0.125*width, y: 0.95833*height), control1: CGPoint(x: 0.08333*width, y: 0.93958*height), control2: CGPoint(x: 0.10208*width, y: 0.95833*height))
        path.addLine(to: CGPoint(x: 0.16667*width, y: 0.95833*height))
        path.addCurve(to: CGPoint(x: 0.20833*width, y: 0.91667*height), control1: CGPoint(x: 0.18958*width, y: 0.95833*height), control2: CGPoint(x: 0.20833*width, y: 0.93958*height))
        path.addLine(to: CGPoint(x: 0.20833*width, y: 0.875*height))
        path.addLine(to: CGPoint(x: 0.54167*width, y: 0.875*height))
        path.addLine(to: CGPoint(x: 0.54167*width, y: 0.91667*height))
        path.addCurve(to: CGPoint(x: 0.58333*width, y: 0.95833*height), control1: CGPoint(x: 0.54167*width, y: 0.93958*height), control2: CGPoint(x: 0.56042*width, y: 0.95833*height))
        path.addLine(to: CGPoint(x: 0.625*width, y: 0.95833*height))
        path.addCurve(to: CGPoint(x: 0.66667*width, y: 0.91667*height), control1: CGPoint(x: 0.64792*width, y: 0.95833*height), control2: CGPoint(x: 0.66667*width, y: 0.93958*height))
        path.addLine(to: CGPoint(x: 0.66667*width, y: 0.8425*height))
        path.addCurve(to: CGPoint(x: 0.70833*width, y: 0.75*height), control1: CGPoint(x: 0.69208*width, y: 0.81958*height), control2: CGPoint(x: 0.70833*width, y: 0.78667*height))
        path.addLine(to: CGPoint(x: 0.70833*width, y: 0.62167*height))
        path.addCurve(to: CGPoint(x: 0.95833*width, y: 0.33333*height), control1: CGPoint(x: 0.84958*width, y: 0.60125*height), control2: CGPoint(x: 0.95833*width, y: 0.48042*height))
        path.addCurve(to: CGPoint(x: 0.66667*width, y: 0.04167*height), control1: CGPoint(x: 0.95833*width, y: 0.17208*height), control2: CGPoint(x: 0.82792*width, y: 0.04167*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.1875*width, y: 0.79167*height))
        path.addCurve(to: CGPoint(x: 0.125*width, y: 0.72917*height), control1: CGPoint(x: 0.15292*width, y: 0.79167*height), control2: CGPoint(x: 0.125*width, y: 0.76375*height))
        path.addCurve(to: CGPoint(x: 0.1875*width, y: 0.66667*height), control1: CGPoint(x: 0.125*width, y: 0.69458*height), control2: CGPoint(x: 0.15292*width, y: 0.66667*height))
        path.addCurve(to: CGPoint(x: 0.25*width, y: 0.72917*height), control1: CGPoint(x: 0.22208*width, y: 0.66667*height), control2: CGPoint(x: 0.25*width, y: 0.69458*height))
        path.addCurve(to: CGPoint(x: 0.1875*width, y: 0.79167*height), control1: CGPoint(x: 0.25*width, y: 0.76375*height), control2: CGPoint(x: 0.22208*width, y: 0.79167*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.125*width, y: 0.54167*height))
        path.addLine(to: CGPoint(x: 0.125*width, y: 0.33333*height))
        path.addLine(to: CGPoint(x: 0.375*width, y: 0.33333*height))
        path.addCurve(to: CGPoint(x: 0.46292*width, y: 0.54167*height), control1: CGPoint(x: 0.375*width, y: 0.415*height), control2: CGPoint(x: 0.40875*width, y: 0.48875*height))
        path.addLine(to: CGPoint(x: 0.125*width, y: 0.54167*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.5625*width, y: 0.79167*height))
        path.addCurve(to: CGPoint(x: 0.5*width, y: 0.72917*height), control1: CGPoint(x: 0.52792*width, y: 0.79167*height), control2: CGPoint(x: 0.5*width, y: 0.76375*height))
        path.addCurve(to: CGPoint(x: 0.5625*width, y: 0.66667*height), control1: CGPoint(x: 0.5*width, y: 0.69458*height), control2: CGPoint(x: 0.52792*width, y: 0.66667*height))
        path.addCurve(to: CGPoint(x: 0.625*width, y: 0.72917*height), control1: CGPoint(x: 0.59708*width, y: 0.66667*height), control2: CGPoint(x: 0.625*width, y: 0.69458*height))
        path.addCurve(to: CGPoint(x: 0.5625*width, y: 0.79167*height), control1: CGPoint(x: 0.625*width, y: 0.76375*height), control2: CGPoint(x: 0.59708*width, y: 0.79167*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.66667*width, y: 0.54167*height))
        path.addCurve(to: CGPoint(x: 0.45833*width, y: 0.33333*height), control1: CGPoint(x: 0.55167*width, y: 0.54167*height), control2: CGPoint(x: 0.45833*width, y: 0.44833*height))
        path.addCurve(to: CGPoint(x: 0.66667*width, y: 0.125*height), control1: CGPoint(x: 0.45833*width, y: 0.21833*height), control2: CGPoint(x: 0.55167*width, y: 0.125*height))
        path.addCurve(to: CGPoint(x: 0.875*width, y: 0.33333*height), control1: CGPoint(x: 0.78167*width, y: 0.125*height), control2: CGPoint(x: 0.875*width, y: 0.21833*height))
        path.addCurve(to: CGPoint(x: 0.66667*width, y: 0.54167*height), control1: CGPoint(x: 0.875*width, y: 0.44833*height), control2: CGPoint(x: 0.78167*width, y: 0.54167*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.6875*width, y: 0.16667*height))
        path.addLine(to: CGPoint(x: 0.625*width, y: 0.16667*height))
        path.addLine(to: CGPoint(x: 0.625*width, y: 0.375*height))
        path.addLine(to: CGPoint(x: 0.77583*width, y: 0.465*height))
        path.addLine(to: CGPoint(x: 0.80708*width, y: 0.41375*height))
        path.addLine(to: CGPoint(x: 0.6875*width, y: 0.34375*height))
        path.closeSubpath()
        return path
    }
}
