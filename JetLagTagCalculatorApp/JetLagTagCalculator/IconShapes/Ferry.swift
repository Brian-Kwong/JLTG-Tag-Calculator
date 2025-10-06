//
//  Ferry.swift
//  Icon Provided by Streamline Icons (https://streamlineicons.com)
//  Converted using SVG-to-SwiftUI https://svg-to-swiftui.quassum.com/
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/6/25.
//

import Foundation
import SwiftUI

struct FerryIcon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.39109 * width, y: 0.06432 * height))
        path.addLine(to: CGPoint(x: 0.60891 * width, y: 0.06432 * height))
        path.addCurve(
            to: CGPoint(x: 0.66337 * width, y: 0.11877 * height),
            control1: CGPoint(x: 0.63903 * width, y: 0.06432 * height),
            control2: CGPoint(x: 0.66337 * width, y: 0.08865 * height)
        )
        path.addLine(to: CGPoint(x: 0.79117 * width, y: 0.11877 * height))
        path.addCurve(
            to: CGPoint(x: 0.82197 * width, y: 0.1865 * height),
            control1: CGPoint(x: 0.82623 * width, y: 0.11877 * height),
            control2: CGPoint(x: 0.84495 * width, y: 0.16013 * height)
        )
        path.addLine(to: CGPoint(x: 0.78589 * width, y: 0.22769 * height))
        path.addLine(to: CGPoint(x: 0.21411 * width, y: 0.22769 * height))
        path.addLine(to: CGPoint(x: 0.17803 * width, y: 0.1865 * height))
        path.addCurve(
            to: CGPoint(x: 0.20883 * width, y: 0.11877 * height),
            control1: CGPoint(x: 0.15505 * width, y: 0.16013 * height),
            control2: CGPoint(x: 0.17377 * width, y: 0.11877 * height)
        )
        path.addLine(to: CGPoint(x: 0.33663 * width, y: 0.11877 * height))
        path.addCurve(
            to: CGPoint(x: 0.39109 * width, y: 0.06432 * height),
            control1: CGPoint(x: 0.33663 * width, y: 0.08865 * height),
            control2: CGPoint(x: 0.36097 * width, y: 0.06432 * height)
        )
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.17326 * width, y: 0.28214 * height))
        path.addLine(to: CGPoint(x: 0.82674 * width, y: 0.28214 * height))
        path.addCurve(
            to: CGPoint(x: 0.88119 * width, y: 0.3366 * height),
            control1: CGPoint(x: 0.85686 * width, y: 0.28214 * height),
            control2: CGPoint(x: 0.88119 * width, y: 0.30648 * height)
        )
        path.addLine(to: CGPoint(x: 0.88119 * width, y: 0.54677 * height))
        path.addCurve(
            to: CGPoint(x: 0.86094 * width, y: 0.61007 * height),
            control1: CGPoint(x: 0.88119 * width, y: 0.5694 * height),
            control2: CGPoint(x: 0.87405 * width, y: 0.59152 * height)
        )
        path.addLine(to: CGPoint(x: 0.77347 * width, y: 0.73243 * height))
        path.addCurve(
            to: CGPoint(x: 0.76411 * width, y: 0.73838 * height),
            control1: CGPoint(x: 0.77024 * width, y: 0.7343 * height),
            control2: CGPoint(x: 0.76718 * width, y: 0.73617 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.67732 * width, y: 0.77225 * height),
            control1: CGPoint(x: 0.73774 * width, y: 0.75659 * height),
            control2: CGPoint(x: 0.70625 * width, y: 0.76901 * height)
        )
        path.addLine(to: CGPoint(x: 0.64907 * width, y: 0.77225 * height))
        path.addCurve(
            to: CGPoint(x: 0.56262 * width, y: 0.73838 * height),
            control1: CGPoint(x: 0.61997 * width, y: 0.76918 * height),
            control2: CGPoint(x: 0.58951 * width, y: 0.75693 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.43721 * width, y: 0.73838 * height),
            control1: CGPoint(x: 0.52502 * width, y: 0.71201 * height),
            control2: CGPoint(x: 0.47481 * width, y: 0.71201 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.3511 * width, y: 0.77225 * height),
            control1: CGPoint(x: 0.41202 * width, y: 0.75574 * height),
            control2: CGPoint(x: 0.3819 * width, y: 0.76901 * height)
        )
        path.addLine(to: CGPoint(x: 0.32285 * width, y: 0.77225 * height))
        path.addCurve(
            to: CGPoint(x: 0.23606 * width, y: 0.73838 * height),
            control1: CGPoint(x: 0.29392 * width, y: 0.76918 * height),
            control2: CGPoint(x: 0.26226 * width, y: 0.75659 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.22653 * width, y: 0.73243 * height),
            control1: CGPoint(x: 0.23299 * width, y: 0.73617 * height),
            control2: CGPoint(x: 0.22976 * width, y: 0.7343 * height)
        )
        path.addLine(to: CGPoint(x: 0.13906 * width, y: 0.61007 * height))
        path.addCurve(
            to: CGPoint(x: 0.11881 * width, y: 0.54677 * height),
            control1: CGPoint(x: 0.12595 * width, y: 0.59152 * height),
            control2: CGPoint(x: 0.11881 * width, y: 0.5694 * height)
        )
        path.addLine(to: CGPoint(x: 0.11881 * width, y: 0.3366 * height))
        path.addCurve(
            to: CGPoint(x: 0.17326 * width, y: 0.28214 * height),
            control1: CGPoint(x: 0.11881 * width, y: 0.30648 * height),
            control2: CGPoint(x: 0.14314 * width, y: 0.28214 * height)
        )
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.22772 * width, y: 0.39106 * height))
        path.addLine(to: CGPoint(x: 0.22772 * width, y: 0.55442 * height))
        path.addLine(to: CGPoint(x: 0.77228 * width, y: 0.55442 * height))
        path.addLine(to: CGPoint(x: 0.77228 * width, y: 0.39106 * height))
        path.addLine(to: CGPoint(x: 0.22772 * width, y: 0.39106 * height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.53148 * width, y: 0.78229 * height))
        path.addCurve(
            to: CGPoint(x: 0.66337 * width, y: 0.8267 * height),
            control1: CGPoint(x: 0.56977 * width, y: 0.80867 * height),
            control2: CGPoint(x: 0.61657 * width, y: 0.8267 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.79508 * width, y: 0.78229 * height),
            control1: CGPoint(x: 0.70915 * width, y: 0.8267 * height),
            control2: CGPoint(x: 0.75748 * width, y: 0.80833 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.86179 * width, y: 0.78518 * height),
            control1: CGPoint(x: 0.81534 * width, y: 0.76782 * height),
            control2: CGPoint(x: 0.8429 * width, y: 0.76901 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.9479 * width, y: 0.82807 * height),
            control1: CGPoint(x: 0.8863 * width, y: 0.80543 * height),
            control2: CGPoint(x: 0.9171 * width, y: 0.82092 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.98857 * width, y: 0.89341 * height),
            control1: CGPoint(x: 0.97717 * width, y: 0.83487 * height),
            control2: CGPoint(x: 0.99538 * width, y: 0.86414 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.92323 * width, y: 0.93408 * height),
            control1: CGPoint(x: 0.98177 * width, y: 0.92268 * height),
            control2: CGPoint(x: 0.9525 * width, y: 0.94089 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.82418 * width, y: 0.89154 * height),
            control1: CGPoint(x: 0.88153 * width, y: 0.92438 * height),
            control2: CGPoint(x: 0.84682 * width, y: 0.90601 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.66337 * width, y: 0.93562 * height),
            control1: CGPoint(x: 0.77483 * width, y: 0.91809 * height),
            control2: CGPoint(x: 0.71953 * width, y: 0.93562 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.52655 * width, y: 0.90345 * height),
            control1: CGPoint(x: 0.60908 * width, y: 0.93562 * height),
            control2: CGPoint(x: 0.56024 * width, y: 0.91877 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.5 * width, y: 0.89035 * height),
            control1: CGPoint(x: 0.51668 * width, y: 0.89886 * height),
            control2: CGPoint(x: 0.50766 * width, y: 0.89443 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.47345 * width, y: 0.90345 * height),
            control1: CGPoint(x: 0.49234 * width, y: 0.89443 * height),
            control2: CGPoint(x: 0.48349 * width, y: 0.89903 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.33663 * width, y: 0.93562 * height),
            control1: CGPoint(x: 0.43976 * width, y: 0.91877 * height),
            control2: CGPoint(x: 0.39092 * width, y: 0.93562 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.17582 * width, y: 0.89171 * height),
            control1: CGPoint(x: 0.28047 * width, y: 0.93562 * height),
            control2: CGPoint(x: 0.22517 * width, y: 0.91809 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.07677 * width, y: 0.93426 * height),
            control1: CGPoint(x: 0.15301 * width, y: 0.90601 * height),
            control2: CGPoint(x: 0.11847 * width, y: 0.92456 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.01143 * width, y: 0.89358 * height),
            control1: CGPoint(x: 0.0475 * width, y: 0.94106 * height),
            control2: CGPoint(x: 0.01823 * width, y: 0.92285 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.0521 * width, y: 0.82824 * height),
            control1: CGPoint(x: 0.00462 * width, y: 0.86431 * height),
            control2: CGPoint(x: 0.02283 * width, y: 0.83504 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.13821 * width, y: 0.78535 * height),
            control1: CGPoint(x: 0.0829 * width, y: 0.82109 * height),
            control2: CGPoint(x: 0.1137 * width, y: 0.8056 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.20492 * width, y: 0.78246 * height),
            control1: CGPoint(x: 0.1571 * width, y: 0.76936 * height),
            control2: CGPoint(x: 0.18467 * width, y: 0.76816 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.33663 * width, y: 0.8267 * height),
            control1: CGPoint(x: 0.24252 * width, y: 0.80833 * height),
            control2: CGPoint(x: 0.29085 * width, y: 0.8267 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.46852 * width, y: 0.78229 * height),
            control1: CGPoint(x: 0.38343 * width, y: 0.8267 * height),
            control2: CGPoint(x: 0.43023 * width, y: 0.80867 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.53148 * width, y: 0.78229 * height),
            control1: CGPoint(x: 0.48741 * width, y: 0.76884 * height),
            control2: CGPoint(x: 0.51259 * width, y: 0.76884 * height)
        )
        path.closeSubpath()
        return path
    }
}
