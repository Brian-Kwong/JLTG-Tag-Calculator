//
//  Metro.swift
//  Icon Provided by Streamline Icons (https://streamlineicons.com)
//  Converted using SVG-to-SwiftUI https://svg-to-swiftui.quassum.com/
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/6/25.
//

import Foundation
import SwiftUI

struct MetroTrain: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.99 * width, y: 0.3824 * height))
        path.addLine(to: CGPoint(x: 0.99 * width, y: 0.9312 * height))
        path.addCurve(
            to: CGPoint(x: 0.9018 * width, y: 0.98212 * height),
            control1: CGPoint(x: 0.99 * width, y: 0.97646 * height),
            control2: CGPoint(x: 0.941 * width, y: 1.00475 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.8724 * width, y: 0.9312 * height),
            control1: CGPoint(x: 0.88361 * width, y: 0.97162 * height),
            control2: CGPoint(x: 0.8724 * width, y: 0.95221 * height)
        )
        path.addLine(to: CGPoint(x: 0.8724 * width, y: 0.3824 * height))
        path.addCurve(
            to: CGPoint(x: 0.6176 * width, y: 0.1276 * height),
            control1: CGPoint(x: 0.87224 * width, y: 0.24174 * height),
            control2: CGPoint(x: 0.75826 * width, y: 0.12776 * height)
        )
        path.addLine(to: CGPoint(x: 0.3824 * width, y: 0.1276 * height))
        path.addCurve(
            to: CGPoint(x: 0.1276 * width, y: 0.3824 * height),
            control1: CGPoint(x: 0.24174 * width, y: 0.12776 * height),
            control2: CGPoint(x: 0.12776 * width, y: 0.24174 * height)
        )
        path.addLine(to: CGPoint(x: 0.1276 * width, y: 0.9312 * height))
        path.addCurve(
            to: CGPoint(x: 0.0394 * width, y: 0.98212 * height),
            control1: CGPoint(x: 0.1276 * width, y: 0.97646 * height),
            control2: CGPoint(x: 0.0786 * width, y: 1.00475 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.01 * width, y: 0.9312 * height),
            control1: CGPoint(x: 0.02121 * width, y: 0.97162 * height),
            control2: CGPoint(x: 0.01 * width, y: 0.95221 * height)
        )
        path.addLine(to: CGPoint(x: 0.01 * width, y: 0.3824 * height))
        path.addCurve(
            to: CGPoint(x: 0.3824 * width, y: 0.01 * height),
            control1: CGPoint(x: 0.01022 * width, y: 0.17682 * height),
            control2: CGPoint(x: 0.17682 * width, y: 0.01022 * height)
        )
        path.addLine(to: CGPoint(x: 0.6176 * width, y: 0.01 * height))
        path.addCurve(
            to: CGPoint(x: 0.99 * width, y: 0.3824 * height),
            control1: CGPoint(x: 0.82318 * width, y: 0.01022 * height),
            control2: CGPoint(x: 0.98978 * width, y: 0.17682 * height)
        )
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.794 * width, y: 0.3824 * height))
        path.addLine(to: CGPoint(x: 0.794 * width, y: 0.7352 * height))
        path.addCurve(
            to: CGPoint(x: 0.70144 * width, y: 0.8649 * height),
            control1: CGPoint(x: 0.79399 * width, y: 0.79376 * height),
            control2: CGPoint(x: 0.75681 * width, y: 0.84585 * height)
        )
        path.addLine(to: CGPoint(x: 0.71124 * width, y: 0.88975 * height))
        path.addCurve(
            to: CGPoint(x: 0.67851 * width, y: 0.96619 * height),
            control1: CGPoint(x: 0.72331 * width, y: 0.91989 * height),
            control2: CGPoint(x: 0.70865 * width, y: 0.95412 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.6568 * width, y: 0.9704 * height),
            control1: CGPoint(x: 0.67161 * width, y: 0.96897 * height),
            control2: CGPoint(x: 0.66424 * width, y: 0.9704 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.60221 * width, y: 0.93345 * height),
            control1: CGPoint(x: 0.63276 * width, y: 0.9704 * height),
            control2: CGPoint(x: 0.61115 * width, y: 0.95577 * height)
        )
        path.addLine(to: CGPoint(x: 0.57771 * width, y: 0.8724 * height))
        path.addLine(to: CGPoint(x: 0.42219 * width, y: 0.8724 * height))
        path.addLine(to: CGPoint(x: 0.39769 * width, y: 0.93345 * height))
        path.addCurve(
            to: CGPoint(x: 0.3432 * width, y: 0.9704 * height),
            control1: CGPoint(x: 0.38877 * width, y: 0.95574 * height),
            control2: CGPoint(x: 0.3672 * width, y: 0.97036 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.32135 * width, y: 0.96619 * height),
            control1: CGPoint(x: 0.33571 * width, y: 0.97042 * height),
            control2: CGPoint(x: 0.32829 * width, y: 0.96899 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.28861 * width, y: 0.88975 * height),
            control1: CGPoint(x: 0.2912 * width, y: 0.95412 * height),
            control2: CGPoint(x: 0.27655 * width, y: 0.91989 * height)
        )
        path.addLine(to: CGPoint(x: 0.29841 * width, y: 0.8649 * height))
        path.addCurve(
            to: CGPoint(x: 0.206 * width, y: 0.7352 * height),
            control1: CGPoint(x: 0.2431 * width, y: 0.8458 * height),
            control2: CGPoint(x: 0.20599 * width, y: 0.79372 * height)
        )
        path.addLine(to: CGPoint(x: 0.206 * width, y: 0.3824 * height))
        path.addCurve(
            to: CGPoint(x: 0.3432 * width, y: 0.2452 * height),
            control1: CGPoint(x: 0.206 * width, y: 0.30663 * height),
            control2: CGPoint(x: 0.26743 * width, y: 0.2452 * height)
        )
        path.addLine(to: CGPoint(x: 0.6568 * width, y: 0.2452 * height))
        path.addCurve(
            to: CGPoint(x: 0.794 * width, y: 0.3824 * height),
            control1: CGPoint(x: 0.73257 * width, y: 0.2452 * height),
            control2: CGPoint(x: 0.794 * width, y: 0.30663 * height)
        )
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.3236 * width, y: 0.3824 * height))
        path.addLine(to: CGPoint(x: 0.3236 * width, y: 0.5588 * height))
        path.addLine(to: CGPoint(x: 0.6764 * width, y: 0.5588 * height))
        path.addLine(to: CGPoint(x: 0.6764 * width, y: 0.3824 * height))
        path.addCurve(
            to: CGPoint(x: 0.6568 * width, y: 0.3628 * height),
            control1: CGPoint(x: 0.6764 * width, y: 0.37158 * height),
            control2: CGPoint(x: 0.66762 * width, y: 0.3628 * height)
        )
        path.addLine(to: CGPoint(x: 0.3432 * width, y: 0.3628 * height))
        path.addCurve(
            to: CGPoint(x: 0.3236 * width, y: 0.3824 * height),
            control1: CGPoint(x: 0.33238 * width, y: 0.3628 * height),
            control2: CGPoint(x: 0.3236 * width, y: 0.37158 * height)
        )
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.6764 * width, y: 0.7352 * height))
        path.addLine(to: CGPoint(x: 0.6764 * width, y: 0.6764 * height))
        path.addLine(to: CGPoint(x: 0.5588 * width, y: 0.6764 * height))
        path.addLine(to: CGPoint(x: 0.5588 * width, y: 0.7548 * height))
        path.addLine(to: CGPoint(x: 0.6568 * width, y: 0.7548 * height))
        path.addCurve(
            to: CGPoint(x: 0.6764 * width, y: 0.7352 * height),
            control1: CGPoint(x: 0.66762 * width, y: 0.7548 * height),
            control2: CGPoint(x: 0.6764 * width, y: 0.74602 * height)
        )
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.4412 * width, y: 0.7548 * height))
        path.addLine(to: CGPoint(x: 0.4412 * width, y: 0.6764 * height))
        path.addLine(to: CGPoint(x: 0.3236 * width, y: 0.6764 * height))
        path.addLine(to: CGPoint(x: 0.3236 * width, y: 0.7352 * height))
        path.addCurve(
            to: CGPoint(x: 0.3432 * width, y: 0.7548 * height),
            control1: CGPoint(x: 0.3236 * width, y: 0.74602 * height),
            control2: CGPoint(x: 0.33238 * width, y: 0.7548 * height)
        )
        path.closeSubpath()
        return path
    }
}
