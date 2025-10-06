//
//  HighSpeedTrain.swift
//  Icon Provided by Streamline Icons (https://streamlineicons.com)
//  Converted using SVG-to-SwiftUI https://svg-to-swiftui.quassum.com/
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/6/25.
//
import Foundation
import SwiftUI

struct HighSpeedTrain: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.50001 * width, y: 0))
        path.addCurve(
            to: CGPoint(x: 0.13051 * width, y: 0.18182 * height),
            control1: CGPoint(x: 0.3104 * width, y: 0),
            control2: CGPoint(x: 0.19422 * width, y: 0.07931 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.07058 * width, y: 0.47174 * height),
            control1: CGPoint(x: 0.06879 * width, y: 0.28114 * height),
            control2: CGPoint(x: 0.05919 * width, y: 0.39743 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.19065 * width, y: 0.7546 * height),
            control1: CGPoint(x: 0.08246 * width, y: 0.54915 * height),
            control2: CGPoint(x: 0.12214 * width, y: 0.66105 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.50001 * width, y: 0.92994 * height),
            control1: CGPoint(x: 0.25932 * width, y: 0.84835 * height),
            control2: CGPoint(x: 0.36201 * width, y: 0.92994 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.80936 * width, y: 0.7546 * height),
            control1: CGPoint(x: 0.63802 * width, y: 0.92994 * height),
            control2: CGPoint(x: 0.74071 * width, y: 0.84835 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.92943 * width, y: 0.47173 * height),
            control1: CGPoint(x: 0.87788 * width, y: 0.66105 * height),
            control2: CGPoint(x: 0.91756 * width, y: 0.54914 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.8695 * width, y: 0.18182 * height),
            control1: CGPoint(x: 0.94082 * width, y: 0.39743 * height),
            control2: CGPoint(x: 0.93122 * width, y: 0.28114 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.50001 * width, y: 0),
            control1: CGPoint(x: 0.8058 * width, y: 0.07931 * height),
            control2: CGPoint(x: 0.68962 * width, y: 0)
        )
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.15884 * width, y: 0.4582 * height))
        path.addCurve(
            to: CGPoint(x: 0.20635 * width, y: 0.22895 * height),
            control1: CGPoint(x: 0.15003 * width, y: 0.40073 * height),
            control2: CGPoint(x: 0.15794 * width, y: 0.30685 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.50001 * width, y: 0.08929 * height),
            control1: CGPoint(x: 0.25278 * width, y: 0.15424 * height),
            control2: CGPoint(x: 0.33935 * width, y: 0.08929 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.79366 * width, y: 0.22895 * height),
            control1: CGPoint(x: 0.66067 * width, y: 0.08929 * height),
            control2: CGPoint(x: 0.74724 * width, y: 0.15424 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.84118 * width, y: 0.4582 * height),
            control1: CGPoint(x: 0.84208 * width, y: 0.30685 * height),
            control2: CGPoint(x: 0.84999 * width, y: 0.40073 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.73734 * width, y: 0.70184 * height),
            control1: CGPoint(x: 0.83134 * width, y: 0.52237 * height),
            control2: CGPoint(x: 0.79681 * width, y: 0.62062 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.73292 * width, y: 0.70777 * height),
            control1: CGPoint(x: 0.73588 * width, y: 0.70383 * height),
            control2: CGPoint(x: 0.73441 * width, y: 0.70581 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.67742 * width, y: 0.64506 * height),
            control1: CGPoint(x: 0.71852 * width, y: 0.68521 * height),
            control2: CGPoint(x: 0.70029 * width, y: 0.66364 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.5 * width, y: 0.58688 * height),
            control1: CGPoint(x: 0.63382 * width, y: 0.60966 * height),
            control2: CGPoint(x: 0.57547 * width, y: 0.58688 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.3226 * width, y: 0.64506 * height),
            control1: CGPoint(x: 0.42454 * width, y: 0.58688 * height),
            control2: CGPoint(x: 0.36619 * width, y: 0.60966 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.26709 * width, y: 0.70776 * height),
            control1: CGPoint(x: 0.29972 * width, y: 0.66364 * height),
            control2: CGPoint(x: 0.28149 * width, y: 0.6852 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.26269 * width, y: 0.70184 * height),
            control1: CGPoint(x: 0.26561 * width, y: 0.7058 * height),
            control2: CGPoint(x: 0.26414 * width, y: 0.70383 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.15884 * width, y: 0.4582 * height),
            control1: CGPoint(x: 0.2032 * width, y: 0.62062 * height),
            control2: CGPoint(x: 0.16868 * width, y: 0.52236 * height)
        )
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.50001 * width, y: 0.18406 * height))
        path.addCurve(
            to: CGPoint(x: 0.25471 * width, y: 0.35421 * height),
            control1: CGPoint(x: 0.34479 * width, y: 0.18406 * height),
            control2: CGPoint(x: 0.26814 * width, y: 0.27527 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.31273 * width, y: 0.44108 * height),
            control1: CGPoint(x: 0.24722 * width, y: 0.39828 * height),
            control2: CGPoint(x: 0.27881 * width, y: 0.43125 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.50001 * width, y: 0.46566 * height),
            control1: CGPoint(x: 0.35415 * width, y: 0.45307 * height),
            control2: CGPoint(x: 0.42093 * width, y: 0.46566 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.68729 * width, y: 0.44108 * height),
            control1: CGPoint(x: 0.57908 * width, y: 0.46566 * height),
            control2: CGPoint(x: 0.64586 * width, y: 0.45307 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.7453 * width, y: 0.3542 * height),
            control1: CGPoint(x: 0.7212 * width, y: 0.43125 * height),
            control2: CGPoint(x: 0.75279 * width, y: 0.39828 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.50001 * width, y: 0.18406 * height),
            control1: CGPoint(x: 0.73187 * width, y: 0.27527 * height),
            control2: CGPoint(x: 0.65522 * width, y: 0.18406 * height)
        )
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.86112 * width, y: 0.80849 * height))
        path.addCurve(
            to: CGPoint(x: 0.9228 * width, y: 0.82196 * height),
            control1: CGPoint(x: 0.88187 * width, y: 0.79518 * height),
            control2: CGPoint(x: 0.90949 * width, y: 0.80121 * height)
        )
        path.addLine(to: CGPoint(x: 0.99293 * width, y: 0.93126 * height))
        path.addCurve(
            to: CGPoint(x: 0.97946 * width, y: 0.99294 * height),
            control1: CGPoint(x: 1.00624 * width, y: 0.95201 * height),
            control2: CGPoint(x: 1.00021 * width, y: 0.97962 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.91778 * width, y: 0.97947 * height),
            control1: CGPoint(x: 0.95871 * width, y: 1.00625 * height),
            control2: CGPoint(x: 0.93109 * width, y: 1.00022 * height)
        )
        path.addLine(to: CGPoint(x: 0.84765 * width, y: 0.87018 * height))
        path.addCurve(
            to: CGPoint(x: 0.86112 * width, y: 0.80849 * height),
            control1: CGPoint(x: 0.83434 * width, y: 0.84943 * height),
            control2: CGPoint(x: 0.84036 * width, y: 0.82181 * height)
        )
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.0772 * width, y: 0.82196 * height))
        path.addCurve(
            to: CGPoint(x: 0.13888 * width, y: 0.80849 * height),
            control1: CGPoint(x: 0.09051 * width, y: 0.80121 * height),
            control2: CGPoint(x: 0.11813 * width, y: 0.79518 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.15235 * width, y: 0.87018 * height),
            control1: CGPoint(x: 0.15963 * width, y: 0.82181 * height),
            control2: CGPoint(x: 0.16566 * width, y: 0.84943 * height)
        )
        path.addLine(to: CGPoint(x: 0.08222 * width, y: 0.97947 * height))
        path.addCurve(
            to: CGPoint(x: 0.02054 * width, y: 0.99294 * height),
            control1: CGPoint(x: 0.06891 * width, y: 1.00022 * height),
            control2: CGPoint(x: 0.04129 * width, y: 1.00625 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.00707 * width, y: 0.93126 * height),
            control1: CGPoint(x: -0.00021 * width, y: 0.97962 * height),
            control2: CGPoint(x: -0.00624 * width, y: 0.95201 * height)
        )
        path.addLine(to: CGPoint(x: 0.0772 * width, y: 0.82196 * height))
        path.closeSubpath()
        return path
    }
}
