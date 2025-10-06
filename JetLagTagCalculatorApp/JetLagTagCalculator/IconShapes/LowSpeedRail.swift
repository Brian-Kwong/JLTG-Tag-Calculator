//
//  LowSpeedRail.swift
//  Icon Provided by Streamline Icons (https://streamlineicons.com)
//  Converted using SVG-to-SwiftUI https://svg-to-swiftui.quassum.com/
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/6/25.
//

import Foundation
import SwiftUI

struct LowSpeedRail: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.16667 * width, y: 0.64583 * height))
        path.addLine(to: CGPoint(x: 0.16667 * width, y: 0.25 * height))
        path.addCurve(
            to: CGPoint(x: 0.18646 * width, y: 0.17552 * height),
            control1: CGPoint(x: 0.16667 * width, y: 0.22153 * height),
            control2: CGPoint(x: 0.17326 * width, y: 0.1967 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.2474 * width, y: 0.12344 * height),
            control1: CGPoint(x: 0.19965 * width, y: 0.15434 * height),
            control2: CGPoint(x: 0.21996 * width, y: 0.13698 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.35156 * width, y: 0.09323 * height),
            control1: CGPoint(x: 0.27483 * width, y: 0.1099 * height),
            control2: CGPoint(x: 0.30955 * width, y: 0.09983 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.5 * width, y: 0.08333 * height),
            control1: CGPoint(x: 0.39358 * width, y: 0.08663 * height),
            control2: CGPoint(x: 0.44306 * width, y: 0.08333 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.6526 * width, y: 0.09271 * height),
            control1: CGPoint(x: 0.55972 * width, y: 0.08333 * height),
            control2: CGPoint(x: 0.61059 * width, y: 0.08646 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.75573 * width, y: 0.1224 * height),
            control1: CGPoint(x: 0.69462 * width, y: 0.09896 * height),
            control2: CGPoint(x: 0.72899 * width, y: 0.10885 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.81458 * width, y: 0.17396 * height),
            control1: CGPoint(x: 0.78246 * width, y: 0.13594 * height),
            control2: CGPoint(x: 0.80208 * width, y: 0.15312 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.83333 * width, y: 0.25 * height),
            control1: CGPoint(x: 0.82708 * width, y: 0.19479 * height),
            control2: CGPoint(x: 0.83333 * width, y: 0.22014 * height)
        )
        path.addLine(to: CGPoint(x: 0.83333 * width, y: 0.64583 * height))
        path.addCurve(
            to: CGPoint(x: 0.79115 * width, y: 0.74948 * height),
            control1: CGPoint(x: 0.83333 * width, y: 0.68681 * height),
            control2: CGPoint(x: 0.81927 * width, y: 0.72135 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.6875 * width, y: 0.79167 * height),
            control1: CGPoint(x: 0.76302 * width, y: 0.7776 * height),
            control2: CGPoint(x: 0.72847 * width, y: 0.79167 * height)
        )
        path.addLine(to: CGPoint(x: 0.71458 * width, y: 0.81875 * height))
        path.addCurve(
            to: CGPoint(x: 0.72188 * width, y: 0.85469 * height),
            control1: CGPoint(x: 0.725 * width, y: 0.82917 * height),
            control2: CGPoint(x: 0.72743 * width, y: 0.84115 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.69063 * width, y: 0.875 * height),
            control1: CGPoint(x: 0.71632 * width, y: 0.86823 * height),
            control2: CGPoint(x: 0.7059 * width, y: 0.875 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.67865 * width, y: 0.87292 * height),
            control1: CGPoint(x: 0.68646 * width, y: 0.875 * height),
            control2: CGPoint(x: 0.68246 * width, y: 0.87431 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.66771 * width, y: 0.86563 * height),
            control1: CGPoint(x: 0.67483 * width, y: 0.87153 * height),
            control2: CGPoint(x: 0.67118 * width, y: 0.8691 * height)
        )
        path.addLine(to: CGPoint(x: 0.59375 * width, y: 0.79167 * height))
        path.addLine(to: CGPoint(x: 0.40625 * width, y: 0.79167 * height))
        path.addLine(to: CGPoint(x: 0.33229 * width, y: 0.86563 * height))
        path.addCurve(
            to: CGPoint(x: 0.32135 * width, y: 0.87292 * height),
            control1: CGPoint(x: 0.32882 * width, y: 0.8691 * height),
            control2: CGPoint(x: 0.32517 * width, y: 0.87153 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.30937 * width, y: 0.875 * height),
            control1: CGPoint(x: 0.31754 * width, y: 0.87431 * height),
            control2: CGPoint(x: 0.31354 * width, y: 0.875 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.27865 * width, y: 0.85469 * height),
            control1: CGPoint(x: 0.29479 * width, y: 0.875 * height),
            control2: CGPoint(x: 0.28455 * width, y: 0.86823 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.28542 * width, y: 0.81875 * height),
            control1: CGPoint(x: 0.27274 * width, y: 0.84115 * height),
            control2: CGPoint(x: 0.275 * width, y: 0.82917 * height)
        )
        path.addLine(to: CGPoint(x: 0.3125 * width, y: 0.79167 * height))
        path.addCurve(
            to: CGPoint(x: 0.20885 * width, y: 0.74948 * height),
            control1: CGPoint(x: 0.27153 * width, y: 0.79167 * height),
            control2: CGPoint(x: 0.23698 * width, y: 0.7776 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.16667 * width, y: 0.64583 * height),
            control1: CGPoint(x: 0.18073 * width, y: 0.72135 * height),
            control2: CGPoint(x: 0.16667 * width, y: 0.68681 * height)
        )
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.5 * width, y: 0.14583 * height))
        path.addCurve(
            to: CGPoint(x: 0.31979 * width, y: 0.16198 * height),
            control1: CGPoint(x: 0.41667 * width, y: 0.14583 * height),
            control2: CGPoint(x: 0.3566 * width, y: 0.15122 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.24062 * width, y: 0.20833 * height),
            control1: CGPoint(x: 0.28299 * width, y: 0.17274 * height),
            control2: CGPoint(x: 0.2566 * width, y: 0.18819 * height)
        )
        path.addLine(to: CGPoint(x: 0.7625 * width, y: 0.20833 * height))
        path.addCurve(
            to: CGPoint(x: 0.68281 * width, y: 0.16302 * height),
            control1: CGPoint(x: 0.75 * width, y: 0.18958 * height),
            control2: CGPoint(x: 0.72344 * width, y: 0.17448 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.5 * width, y: 0.14583 * height),
            control1: CGPoint(x: 0.64219 * width, y: 0.15156 * height),
            control2: CGPoint(x: 0.58125 * width, y: 0.14583 * height)
        )
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.22917 * width, y: 0.43229 * height))
        path.addLine(to: CGPoint(x: 0.47292 * width, y: 0.43229 * height))
        path.addLine(to: CGPoint(x: 0.47292 * width, y: 0.27083 * height))
        path.addLine(to: CGPoint(x: 0.22917 * width, y: 0.27083 * height))
        path.addLine(to: CGPoint(x: 0.22917 * width, y: 0.43229 * height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.6875 * width, y: 0.49479 * height))
        path.addLine(to: CGPoint(x: 0.22917 * width, y: 0.49479 * height))
        path.addLine(to: CGPoint(x: 0.77083 * width, y: 0.49479 * height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.53542 * width, y: 0.43229 * height))
        path.addLine(to: CGPoint(x: 0.77083 * width, y: 0.43229 * height))
        path.addLine(to: CGPoint(x: 0.77083 * width, y: 0.27083 * height))
        path.addLine(to: CGPoint(x: 0.53542 * width, y: 0.27083 * height))
        path.addLine(to: CGPoint(x: 0.53542 * width, y: 0.43229 * height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.34896 * width, y: 0.67188 * height))
        path.addCurve(
            to: CGPoint(x: 0.38958 * width, y: 0.65521 * height),
            control1: CGPoint(x: 0.36493 * width, y: 0.67188 * height),
            control2: CGPoint(x: 0.37847 * width, y: 0.66632 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.40625 * width, y: 0.61458 * height),
            control1: CGPoint(x: 0.40069 * width, y: 0.6441 * height),
            control2: CGPoint(x: 0.40625 * width, y: 0.63056 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.38958 * width, y: 0.57396 * height),
            control1: CGPoint(x: 0.40625 * width, y: 0.59861 * height),
            control2: CGPoint(x: 0.40069 * width, y: 0.58507 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.34896 * width, y: 0.55729 * height),
            control1: CGPoint(x: 0.37847 * width, y: 0.56285 * height),
            control2: CGPoint(x: 0.36493 * width, y: 0.55729 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.30833 * width, y: 0.57396 * height),
            control1: CGPoint(x: 0.33299 * width, y: 0.55729 * height),
            control2: CGPoint(x: 0.31944 * width, y: 0.56285 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.29167 * width, y: 0.61458 * height),
            control1: CGPoint(x: 0.29722 * width, y: 0.58507 * height),
            control2: CGPoint(x: 0.29167 * width, y: 0.59861 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.30833 * width, y: 0.65521 * height),
            control1: CGPoint(x: 0.29167 * width, y: 0.63056 * height),
            control2: CGPoint(x: 0.29722 * width, y: 0.6441 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.34896 * width, y: 0.67188 * height),
            control1: CGPoint(x: 0.31944 * width, y: 0.66632 * height),
            control2: CGPoint(x: 0.33299 * width, y: 0.67188 * height)
        )
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.65104 * width, y: 0.67188 * height))
        path.addCurve(
            to: CGPoint(x: 0.69167 * width, y: 0.65521 * height),
            control1: CGPoint(x: 0.66701 * width, y: 0.67188 * height),
            control2: CGPoint(x: 0.68056 * width, y: 0.66632 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.70833 * width, y: 0.61458 * height),
            control1: CGPoint(x: 0.70278 * width, y: 0.6441 * height),
            control2: CGPoint(x: 0.70833 * width, y: 0.63056 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.69167 * width, y: 0.57396 * height),
            control1: CGPoint(x: 0.70833 * width, y: 0.59861 * height),
            control2: CGPoint(x: 0.70278 * width, y: 0.58507 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.65104 * width, y: 0.55729 * height),
            control1: CGPoint(x: 0.68056 * width, y: 0.56285 * height),
            control2: CGPoint(x: 0.66701 * width, y: 0.55729 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.61042 * width, y: 0.57396 * height),
            control1: CGPoint(x: 0.63507 * width, y: 0.55729 * height),
            control2: CGPoint(x: 0.62153 * width, y: 0.56285 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.59375 * width, y: 0.61458 * height),
            control1: CGPoint(x: 0.59931 * width, y: 0.58507 * height),
            control2: CGPoint(x: 0.59375 * width, y: 0.59861 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.61042 * width, y: 0.65521 * height),
            control1: CGPoint(x: 0.59375 * width, y: 0.63056 * height),
            control2: CGPoint(x: 0.59931 * width, y: 0.6441 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.65104 * width, y: 0.67188 * height),
            control1: CGPoint(x: 0.62153 * width, y: 0.66632 * height),
            control2: CGPoint(x: 0.63507 * width, y: 0.67188 * height)
        )
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.3125 * width, y: 0.73438 * height))
        path.addLine(to: CGPoint(x: 0.6875 * width, y: 0.73438 * height))
        path.addCurve(
            to: CGPoint(x: 0.74687 * width, y: 0.70833 * height),
            control1: CGPoint(x: 0.71111 * width, y: 0.73438 * height),
            control2: CGPoint(x: 0.7309 * width, y: 0.72569 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.77083 * width, y: 0.64583 * height),
            control1: CGPoint(x: 0.76285 * width, y: 0.69097 * height),
            control2: CGPoint(x: 0.77083 * width, y: 0.67014 * height)
        )
        path.addLine(to: CGPoint(x: 0.77083 * width, y: 0.49479 * height))
        path.addLine(to: CGPoint(x: 0.22917 * width, y: 0.49479 * height))
        path.addLine(to: CGPoint(x: 0.22917 * width, y: 0.64583 * height))
        path.addCurve(
            to: CGPoint(x: 0.25313 * width, y: 0.70833 * height),
            control1: CGPoint(x: 0.22917 * width, y: 0.67014 * height),
            control2: CGPoint(x: 0.23715 * width, y: 0.69097 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.3125 * width, y: 0.73438 * height),
            control1: CGPoint(x: 0.2691 * width, y: 0.72569 * height),
            control2: CGPoint(x: 0.28889 * width, y: 0.73438 * height)
        )
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.5 * width, y: 0.20833 * height))
        path.addLine(to: CGPoint(x: 0.7625 * width, y: 0.20833 * height))
        path.addLine(to: CGPoint(x: 0.5 * width, y: 0.20833 * height))
        path.closeSubpath()
        return path
    }
}
