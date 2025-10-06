//
//  Bus.swift
//  Icon Provided by Streamline Icons (https://streamlineicons.com)
//  Converted using SVG-to-SwiftUI https://svg-to-swiftui.quassum.com/
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/6/25.
//

import Foundation
import SwiftUI

struct BusIcon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.5 * width, y: 0.10417 * height))
        path.addCurve(
            to: CGPoint(x: 0.24116 * width, y: 0.11295 * height),
            control1: CGPoint(x: 0.38162 * width, y: 0.10417 * height),
            control2: CGPoint(x: 0.29671 * width, y: 0.10854 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.18426 * width, y: 0.1707 * height),
            control1: CGPoint(x: 0.20996 * width, y: 0.11543 * height),
            control2: CGPoint(x: 0.18658 * width, y: 0.13893 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.17754 * width, y: 0.30803 * height),
            control1: CGPoint(x: 0.18174 * width, y: 0.20505 * height),
            control2: CGPoint(x: 0.17921 * width, y: 0.25051 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.13589 * width, y: 0.34849 * height),
            control1: CGPoint(x: 0.17688 * width, y: 0.33056 * height),
            control2: CGPoint(x: 0.15843 * width, y: 0.34849 * height)
        )
        path.addLine(to: CGPoint(x: 0.13096 * width, y: 0.34849 * height))
        path.addCurve(
            to: CGPoint(x: 0.11586 * width, y: 0.36107 * height),
            control1: CGPoint(x: 0.1212 * width, y: 0.34849 * height),
            control2: CGPoint(x: 0.11615 * width, y: 0.35496 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.11458 * width, y: 0.41787 * height),
            control1: CGPoint(x: 0.11512 * width, y: 0.37636 * height),
            control2: CGPoint(x: 0.11458 * width, y: 0.39529 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.11551 * width, y: 0.46362 * height),
            control1: CGPoint(x: 0.11458 * width, y: 0.43685 * height),
            control2: CGPoint(x: 0.11497 * width, y: 0.45187 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.11596 * width, y: 0.46579 * height),
            control1: CGPoint(x: 0.11557 * width, y: 0.46485 * height),
            control2: CGPoint(x: 0.11582 * width, y: 0.4655 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.11672 * width, y: 0.46675 * height),
            control1: CGPoint(x: 0.11611 * width, y: 0.46609 * height),
            control2: CGPoint(x: 0.11632 * width, y: 0.4664 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.12372 * width, y: 0.46875 * height),
            control1: CGPoint(x: 0.11748 * width, y: 0.46742 * height),
            control2: CGPoint(x: 0.11963 * width, y: 0.46875 * height)
        )
        path.addLine(to: CGPoint(x: 0.13412 * width, y: 0.46875 * height))
        path.addCurve(
            to: CGPoint(x: 0.17578 * width, y: 0.51016 * height),
            control1: CGPoint(x: 0.15703 * width, y: 0.46875 * height),
            control2: CGPoint(x: 0.17564 * width, y: 0.48725 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.18134 * width, y: 0.75575 * height),
            control1: CGPoint(x: 0.17649 * width, y: 0.62354 * height),
            control2: CGPoint(x: 0.17907 * width, y: 0.70463 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.21387 * width, y: 0.78863 * height),
            control1: CGPoint(x: 0.18214 * width, y: 0.77397 * height),
            control2: CGPoint(x: 0.19597 * width, y: 0.78776 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.5 * width, y: 0.79451 * height),
            control1: CGPoint(x: 0.27079 * width, y: 0.79139 * height),
            control2: CGPoint(x: 0.36506 * width, y: 0.79451 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.78613 * width, y: 0.78863 * height),
            control1: CGPoint(x: 0.63494 * width, y: 0.79451 * height),
            control2: CGPoint(x: 0.72921 * width, y: 0.79139 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.81866 * width, y: 0.75575 * height),
            control1: CGPoint(x: 0.80403 * width, y: 0.78776 * height),
            control2: CGPoint(x: 0.81786 * width, y: 0.77397 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.82422 * width, y: 0.51016 * height),
            control1: CGPoint(x: 0.82093 * width, y: 0.70463 * height),
            control2: CGPoint(x: 0.82351 * width, y: 0.62354 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.86589 * width, y: 0.46875 * height),
            control1: CGPoint(x: 0.82436 * width, y: 0.48725 * height),
            control2: CGPoint(x: 0.84298 * width, y: 0.46875 * height)
        )
        path.addLine(to: CGPoint(x: 0.87628 * width, y: 0.46875 * height))
        path.addCurve(
            to: CGPoint(x: 0.88329 * width, y: 0.46675 * height),
            control1: CGPoint(x: 0.88037 * width, y: 0.46875 * height),
            control2: CGPoint(x: 0.88252 * width, y: 0.46742 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.88404 * width, y: 0.46579 * height),
            control1: CGPoint(x: 0.88367 * width, y: 0.4664 * height),
            control2: CGPoint(x: 0.88389 * width, y: 0.46609 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.88449 * width, y: 0.46362 * height),
            control1: CGPoint(x: 0.88418 * width, y: 0.4655 * height),
            control2: CGPoint(x: 0.88443 * width, y: 0.46486 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.88542 * width, y: 0.41787 * height),
            control1: CGPoint(x: 0.88504 * width, y: 0.45187 * height),
            control2: CGPoint(x: 0.88542 * width, y: 0.43685 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.88414 * width, y: 0.36107 * height),
            control1: CGPoint(x: 0.88542 * width, y: 0.39529 * height),
            control2: CGPoint(x: 0.88487 * width, y: 0.37636 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.86904 * width, y: 0.34849 * height),
            control1: CGPoint(x: 0.88385 * width, y: 0.35496 * height),
            control2: CGPoint(x: 0.8788 * width, y: 0.34849 * height)
        )
        path.addLine(to: CGPoint(x: 0.86411 * width, y: 0.34849 * height))
        path.addCurve(
            to: CGPoint(x: 0.82246 * width, y: 0.30803 * height),
            control1: CGPoint(x: 0.84157 * width, y: 0.34849 * height),
            control2: CGPoint(x: 0.82312 * width, y: 0.33056 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.81574 * width, y: 0.1707 * height),
            control1: CGPoint(x: 0.82079 * width, y: 0.25051 * height),
            control2: CGPoint(x: 0.81826 * width, y: 0.20505 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.75884 * width, y: 0.11295 * height),
            control1: CGPoint(x: 0.81342 * width, y: 0.13893 * height),
            control2: CGPoint(x: 0.79004 * width, y: 0.11543 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.5 * width, y: 0.10417 * height),
            control1: CGPoint(x: 0.70329 * width, y: 0.10854 * height),
            control2: CGPoint(x: 0.61838 * width, y: 0.10417 * height)
        )
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.23456 * width, y: 0.02988 * height))
        path.addCurve(
            to: CGPoint(x: 0.5 * width, y: 0.02083 * height),
            control1: CGPoint(x: 0.29245 * width, y: 0.02528 * height),
            control2: CGPoint(x: 0.37957 * width, y: 0.02083 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.76544 * width, y: 0.02988 * height),
            control1: CGPoint(x: 0.62043 * width, y: 0.02083 * height),
            control2: CGPoint(x: 0.70755 * width, y: 0.02528 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.89886 * width, y: 0.16463 * height),
            control1: CGPoint(x: 0.83816 * width, y: 0.03565 * height),
            control2: CGPoint(x: 0.89357 * width, y: 0.09232 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.90463 * width, y: 0.27163 * height),
            control1: CGPoint(x: 0.90094 * width, y: 0.19307 * height),
            control2: CGPoint(x: 0.90301 * width, y: 0.22858 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.96738 * width, y: 0.35708 * height),
            control1: CGPoint(x: 0.93914 * width, y: 0.28462 * height),
            control2: CGPoint(x: 0.96542 * width, y: 0.31618 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.96875 * width, y: 0.41788 * height),
            control1: CGPoint(x: 0.96818 * width, y: 0.3737 * height),
            control2: CGPoint(x: 0.96875 * width, y: 0.39396 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.96773 * width, y: 0.46748 * height),
            control1: CGPoint(x: 0.96875 * width, y: 0.43795 * height),
            control2: CGPoint(x: 0.96835 * width, y: 0.45427 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.90725 * width, y: 0.54702 * height),
            control1: CGPoint(x: 0.96588 * width, y: 0.50755 * height),
            control2: CGPoint(x: 0.93996 * width, y: 0.53599 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.90192 * width, y: 0.75944 * height),
            control1: CGPoint(x: 0.90627 * width, y: 0.64267 * height),
            control2: CGPoint(x: 0.90398 * width, y: 0.71293 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.79546 * width, y: 0.87149 * height),
            control1: CGPoint(x: 0.89929 * width, y: 0.81861 * height),
            control2: CGPoint(x: 0.85407 * width, y: 0.86607 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.79364 * width, y: 0.93251 * height),
            control1: CGPoint(x: 0.79537 * width, y: 0.89663 * height),
            control2: CGPoint(x: 0.79455 * width, y: 0.91719 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.7504 * width, y: 0.97671 * height),
            control1: CGPoint(x: 0.79224 * width, y: 0.95614 * height),
            control2: CGPoint(x: 0.77396 * width, y: 0.97478 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.69343 * width, y: 0.97917 * height),
            control1: CGPoint(x: 0.7347 * width, y: 0.97799 * height),
            control2: CGPoint(x: 0.71454 * width, y: 0.97917 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.63646 * width, y: 0.97671 * height),
            control1: CGPoint(x: 0.67231 * width, y: 0.97917 * height),
            control2: CGPoint(x: 0.65216 * width, y: 0.97799 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.59321 * width, y: 0.93251 * height),
            control1: CGPoint(x: 0.6129 * width, y: 0.97478 * height),
            control2: CGPoint(x: 0.59461 * width, y: 0.95614 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.59143 * width, y: 0.87735 * height),
            control1: CGPoint(x: 0.59237 * width, y: 0.91839 * height),
            control2: CGPoint(x: 0.59162 * width, y: 0.89983 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.5 * width, y: 0.87785 * height),
            control1: CGPoint(x: 0.56328 * width, y: 0.87766 * height),
            control2: CGPoint(x: 0.53282 * width, y: 0.87785 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.40858 * width, y: 0.87735 * height),
            control1: CGPoint(x: 0.46719 * width, y: 0.87785 * height),
            control2: CGPoint(x: 0.43673 * width, y: 0.87766 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.4068 * width, y: 0.93251 * height),
            control1: CGPoint(x: 0.4084 * width, y: 0.89983 * height),
            control2: CGPoint(x: 0.40764 * width, y: 0.91839 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.36355 * width, y: 0.97671 * height),
            control1: CGPoint(x: 0.4054 * width, y: 0.95614 * height),
            control2: CGPoint(x: 0.38712 * width, y: 0.97478 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.30659 * width, y: 0.97917 * height),
            control1: CGPoint(x: 0.34785 * width, y: 0.97799 * height),
            control2: CGPoint(x: 0.3277 * width, y: 0.97917 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.24962 * width, y: 0.97671 * height),
            control1: CGPoint(x: 0.28547 * width, y: 0.97917 * height),
            control2: CGPoint(x: 0.26532 * width, y: 0.97799 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.20637 * width, y: 0.93251 * height),
            control1: CGPoint(x: 0.22605 * width, y: 0.97478 * height),
            control2: CGPoint(x: 0.20777 * width, y: 0.95614 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.20456 * width, y: 0.87149 * height),
            control1: CGPoint(x: 0.20546 * width, y: 0.91719 * height),
            control2: CGPoint(x: 0.20465 * width, y: 0.89663 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.09808 * width, y: 0.75944 * height),
            control1: CGPoint(x: 0.14594 * width, y: 0.86608 * height),
            control2: CGPoint(x: 0.10071 * width, y: 0.81862 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.09275 * width, y: 0.54702 * height),
            control1: CGPoint(x: 0.09602 * width, y: 0.71293 * height),
            control2: CGPoint(x: 0.09373 * width, y: 0.64267 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.03227 * width, y: 0.46748 * height),
            control1: CGPoint(x: 0.06004 * width, y: 0.53599 * height),
            control2: CGPoint(x: 0.03412 * width, y: 0.50755 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.03125 * width, y: 0.41787 * height),
            control1: CGPoint(x: 0.03165 * width, y: 0.45427 * height),
            control2: CGPoint(x: 0.03125 * width, y: 0.43795 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.03262 * width, y: 0.35708 * height),
            control1: CGPoint(x: 0.03125 * width, y: 0.39396 * height),
            control2: CGPoint(x: 0.03182 * width, y: 0.3737 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.09537 * width, y: 0.27163 * height),
            control1: CGPoint(x: 0.03458 * width, y: 0.31618 * height),
            control2: CGPoint(x: 0.06086 * width, y: 0.28462 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.10114 * width, y: 0.16463 * height),
            control1: CGPoint(x: 0.09699 * width, y: 0.22858 * height),
            control2: CGPoint(x: 0.09906 * width, y: 0.19307 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.23456 * width, y: 0.02988 * height),
            control1: CGPoint(x: 0.10643 * width, y: 0.09232 * height),
            control2: CGPoint(x: 0.16184 * width, y: 0.03565 * height)
        )
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.27554 * width, y: 0.16371 * height))
        path.addCurve(
            to: CGPoint(x: 0.49999 * width, y: 0.15389 * height),
            control1: CGPoint(x: 0.31234 * width, y: 0.15965 * height),
            control2: CGPoint(x: 0.38484 * width, y: 0.15389 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.72444 * width, y: 0.16371 * height),
            control1: CGPoint(x: 0.61514 * width, y: 0.15389 * height),
            control2: CGPoint(x: 0.68765 * width, y: 0.15965 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.76577 * width, y: 0.20569 * height),
            control1: CGPoint(x: 0.74667 * width, y: 0.16617 * height),
            control2: CGPoint(x: 0.76362 * width, y: 0.18353 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.77509 * width, y: 0.44935 * height),
            control1: CGPoint(x: 0.76954 * width, y: 0.24451 * height),
            control2: CGPoint(x: 0.77509 * width, y: 0.32309 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.77361 * width, y: 0.5921 * height),
            control1: CGPoint(x: 0.77509 * width, y: 0.50583 * height),
            control2: CGPoint(x: 0.77447 * width, y: 0.55329 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.7632 * width, y: 0.60228 * height),
            control1: CGPoint(x: 0.77348 * width, y: 0.59776 * height),
            control2: CGPoint(x: 0.76886 * width, y: 0.60228 * height)
        )
        path.addLine(to: CGPoint(x: 0.23679 * width, y: 0.60228 * height))
        path.addCurve(
            to: CGPoint(x: 0.22637 * width, y: 0.5921 * height),
            control1: CGPoint(x: 0.23113 * width, y: 0.60228 * height),
            control2: CGPoint(x: 0.2265 * width, y: 0.59776 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.22489 * width, y: 0.44935 * height),
            control1: CGPoint(x: 0.22551 * width, y: 0.55329 * height),
            control2: CGPoint(x: 0.22489 * width, y: 0.50583 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.23421 * width, y: 0.20569 * height),
            control1: CGPoint(x: 0.22489 * width, y: 0.32309 * height),
            control2: CGPoint(x: 0.23044 * width, y: 0.24451 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.27554 * width, y: 0.16371 * height),
            control1: CGPoint(x: 0.23637 * width, y: 0.18353 * height),
            control2: CGPoint(x: 0.25332 * width, y: 0.16617 * height)
        )
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.25474 * width, y: 0.71403 * height))
        path.addCurve(
            to: CGPoint(x: 0.29641 * width, y: 0.67236 * height),
            control1: CGPoint(x: 0.25474 * width, y: 0.69102 * height),
            control2: CGPoint(x: 0.2734 * width, y: 0.67236 * height)
        )
        path.addLine(to: CGPoint(x: 0.35749 * width, y: 0.67236 * height))
        path.addCurve(
            to: CGPoint(x: 0.39915 * width, y: 0.71403 * height),
            control1: CGPoint(x: 0.3805 * width, y: 0.67236 * height),
            control2: CGPoint(x: 0.39915 * width, y: 0.69102 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.35749 * width, y: 0.7557 * height),
            control1: CGPoint(x: 0.39915 * width, y: 0.73704 * height),
            control2: CGPoint(x: 0.3805 * width, y: 0.7557 * height)
        )
        path.addLine(to: CGPoint(x: 0.29641 * width, y: 0.7557 * height))
        path.addCurve(
            to: CGPoint(x: 0.25474 * width, y: 0.71403 * height),
            control1: CGPoint(x: 0.2734 * width, y: 0.7557 * height),
            control2: CGPoint(x: 0.25474 * width, y: 0.73704 * height)
        )
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.70359 * width, y: 0.67236 * height))
        path.addCurve(
            to: CGPoint(x: 0.74526 * width, y: 0.71403 * height),
            control1: CGPoint(x: 0.7266 * width, y: 0.67236 * height),
            control2: CGPoint(x: 0.74526 * width, y: 0.69102 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.70359 * width, y: 0.7557 * height),
            control1: CGPoint(x: 0.74526 * width, y: 0.73704 * height),
            control2: CGPoint(x: 0.7266 * width, y: 0.7557 * height)
        )
        path.addLine(to: CGPoint(x: 0.64251 * width, y: 0.7557 * height))
        path.addCurve(
            to: CGPoint(x: 0.60085 * width, y: 0.71403 * height),
            control1: CGPoint(x: 0.6195 * width, y: 0.7557 * height),
            control2: CGPoint(x: 0.60085 * width, y: 0.73704 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.64251 * width, y: 0.67236 * height),
            control1: CGPoint(x: 0.60085 * width, y: 0.69102 * height),
            control2: CGPoint(x: 0.6195 * width, y: 0.67236 * height)
        )
        path.addLine(to: CGPoint(x: 0.70359 * width, y: 0.67236 * height))
        path.closeSubpath()
        return path
    }
}
