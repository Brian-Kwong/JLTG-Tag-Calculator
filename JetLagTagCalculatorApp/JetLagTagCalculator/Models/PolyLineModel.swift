//
//  PolyLineModel.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/9/25.
//

import Foundation
import CoreLocation
import SwiftUI

struct PolyLineModel: Identifiable {
    var id = UUID()
    var polyLineColor : Color
    var polylineCoordinates : [CLLocationCoordinate2D]
}
