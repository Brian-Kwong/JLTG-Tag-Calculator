//
//  Coins.swift
//  Icon Provided by Streamline Icons (https://streamlineicons.com)
//  Converted using SVG-to-SwiftUI https://svg-to-swiftui.quassum.com/
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/6/25.
//

import Foundation
import SwiftUI

struct Coins: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.46875 * width, y: 0.18906 * height))
        path.addCurve(
            to: CGPoint(x: 0.38633 * width, y: 0.26367 * height),
            control1: CGPoint(x: 0.46875 * width, y: 0.21953 * height),
            control2: CGPoint(x: 0.43633 * width, y: 0.24687 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.05859 * width, y: 0.18906 * height),
            control1: CGPoint(x: 0.09102 * width, y: 0.24688 * height),
            control2: CGPoint(x: 0.05859 * width, y: 0.21953 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.26367 * width, y: 0.0957 * height),
            control1: CGPoint(x: 0.05859 * width, y: 0.1375 * height),
            control2: CGPoint(x: 0.15039 * width, y: 0.0957 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.46875 * width, y: 0.18906 * height),
            control1: CGPoint(x: 0.37695 * width, y: 0.0957 * height),
            control2: CGPoint(x: 0.46875 * width, y: 0.1375 * height)
        )
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.46875 * width, y: 0.18906 * height))
        path.addLine(to: CGPoint(x: 0.46875 * width, y: 0.33828 * height))
        path.addCurve(
            to: CGPoint(x: 0.38633 * width, y: 0.41289 * height),
            control1: CGPoint(x: 0.46875 * width, y: 0.36875 * height),
            control2: CGPoint(x: 0.43633 * width, y: 0.39609 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.05859 * width, y: 0.33828 * height),
            control1: CGPoint(x: 0.09102 * width, y: 0.39609 * height),
            control2: CGPoint(x: 0.05859 * width, y: 0.36875 * height)
        )
        path.addLine(to: CGPoint(x: 0.05859 * width, y: 0.18906 * height))
        path.addCurve(
            to: CGPoint(x: 0.14102 * width, y: 0.26367 * height),
            control1: CGPoint(x: 0.05859 * width, y: 0.21953 * height),
            control2: CGPoint(x: 0.09102 * width, y: 0.24687 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.46875 * width, y: 0.18906 * height),
            control1: CGPoint(x: 0.43633 * width, y: 0.24688 * height),
            control2: CGPoint(x: 0.46875 * width, y: 0.21953 * height)
        )
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.46875 * width, y: 0.33828 * height))
        path.addLine(to: CGPoint(x: 0.46875 * width, y: 0.4875 * height))
        path.addCurve(
            to: CGPoint(x: 0.38633 * width, y: 0.56211 * height),
            control1: CGPoint(x: 0.46875 * width, y: 0.51797 * height),
            control2: CGPoint(x: 0.43633 * width, y: 0.54531 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.05859 * width, y: 0.4875 * height),
            control1: CGPoint(x: 0.09102 * width, y: 0.54688 * height),
            control2: CGPoint(x: 0.05859 * width, y: 0.51797 * height)
        )
        path.addLine(to: CGPoint(x: 0.05859 * width, y: 0.33828 * height))
        path.addCurve(
            to: CGPoint(x: 0.14102 * width, y: 0.41289 * height),
            control1: CGPoint(x: 0.05859 * width, y: 0.36875 * height),
            control2: CGPoint(x: 0.09102 * width, y: 0.39609 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.46875 * width, y: 0.33828 * height),
            control1: CGPoint(x: 0.43633 * width, y: 0.39609 * height),
            control2: CGPoint(x: 0.46875 * width, y: 0.36875 * height)
        )
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.46875 * width, y: 0.4875 * height))
        path.addLine(to: CGPoint(x: 0.46875 * width, y: 0.63672 * height))
        path.addCurve(
            to: CGPoint(x: 0.26367 * width, y: 0.72969 * height),
            control1: CGPoint(x: 0.46875 * width, y: 0.68789 * height),
            control2: CGPoint(x: 0.37695 * width, y: 0.72969 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.05859 * width, y: 0.63672 * height),
            control1: CGPoint(x: 0.15039 * width, y: 0.72969 * height),
            control2: CGPoint(x: 0.05859 * width, y: 0.68789 * height)
        )
        path.addLine(to: CGPoint(x: 0.05859 * width, y: 0.4875 * height))
        path.addCurve(
            to: CGPoint(x: 0.14102 * width, y: 0.56211 * height),
            control1: CGPoint(x: 0.05859 * width, y: 0.51797 * height),
            control2: CGPoint(x: 0.09102 * width, y: 0.54531 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.46875 * width, y: 0.4875 * height),
            control1: CGPoint(x: 0.43633 * width, y: 0.54688 * height),
            control2: CGPoint(x: 0.46875 * width, y: 0.51797 * height)
        )
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.87891 * width, y: 0.4875 * height))
        path.addLine(to: CGPoint(x: 0.87891 * width, y: 0.63672 * height))
        path.addCurve(
            to: CGPoint(x: 0.67383 * width, y: 0.72969 * height),
            control1: CGPoint(x: 0.87891 * width, y: 0.68789 * height),
            control2: CGPoint(x: 0.78711 * width, y: 0.72969 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.46875 * width, y: 0.63672 * height),
            control1: CGPoint(x: 0.56055 * width, y: 0.72969 * height),
            control2: CGPoint(x: 0.46875 * width, y: 0.68789 * height)
        )
        path.addLine(to: CGPoint(x: 0.46875 * width, y: 0.4875 * height))
        path.addCurve(
            to: CGPoint(x: 0.55117 * width, y: 0.56211 * height),
            control1: CGPoint(x: 0.46875 * width, y: 0.51797 * height),
            control2: CGPoint(x: 0.50117 * width, y: 0.54531 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.87891 * width, y: 0.4875 * height),
            control1: CGPoint(x: 0.84648 * width, y: 0.54688 * height),
            control2: CGPoint(x: 0.87891 * width, y: 0.51797 * height)
        )
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.46875 * width, y: 0.4875 * height))
        path.addLine(to: CGPoint(x: 0.46875 * width, y: 0.78555 * height))
        path.addCurve(
            to: CGPoint(x: 0.26367 * width, y: 0.87891 * height),
            control1: CGPoint(x: 0.46875 * width, y: 0.83711 * height),
            control2: CGPoint(x: 0.37695 * width, y: 0.87891 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.05859 * width, y: 0.78555 * height),
            control1: CGPoint(x: 0.15039 * width, y: 0.87891 * height),
            control2: CGPoint(x: 0.05859 * width, y: 0.83711 * height)
        )
        path.addLine(to: CGPoint(x: 0.05859 * width, y: 0.4875 * height))
        path.move(to: CGPoint(x: 0.87891 * width, y: 0.52656 * height))
        path.addLine(to: CGPoint(x: 0.87891 * width, y: 0.78555 * height))
        path.addCurve(
            to: CGPoint(x: 0.67383 * width, y: 0.87891 * height),
            control1: CGPoint(x: 0.87891 * width, y: 0.83711 * height),
            control2: CGPoint(x: 0.78711 * width, y: 0.87891 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.46875 * width, y: 0.78555 * height),
            control1: CGPoint(x: 0.56055 * width, y: 0.87891 * height),
            control2: CGPoint(x: 0.46875 * width, y: 0.83711 * height)
        )
        path.addLine(to: CGPoint(x: 0.46875 * width, y: 0.4875 * height))
        path.move(to: CGPoint(x: 0.87891 * width, y: 0.26367 * height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.87891 * width, y: 0.4875 * height))
        path.addCurve(
            to: CGPoint(x: 0.79648 * width, y: 0.56211 * height),
            control1: CGPoint(x: 0.87891 * width, y: 0.51797 * height),
            control2: CGPoint(x: 0.84648 * width, y: 0.54531 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.46875 * width, y: 0.4875 * height),
            control1: CGPoint(x: 0.50117 * width, y: 0.54688 * height),
            control2: CGPoint(x: 0.46875 * width, y: 0.51797 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.53828 * width, y: 0.41719 * height),
            control1: CGPoint(x: 0.46875 * width, y: 0.45703 * height),
            control2: CGPoint(x: 0.4957 * width, y: 0.43438 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.87891 * width, y: 0.4875 * height),
            control1: CGPoint(x: 0.85195 * width, y: 0.43438 * height),
            control2: CGPoint(x: 0.87891 * width, y: 0.45938 * height)
        )
        path.closeSubpath()
        return path
    }
}
