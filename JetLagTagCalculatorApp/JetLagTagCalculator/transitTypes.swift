//
//  transitTypes.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/2/25.
//

import Foundation

enum transitOpitions : String {
    case all
    case lowSpeedRail
    case highSpeedRail
    case bus
    case scooter
    case plane
}

struct transitTypes: Identifiable {
    let id = UUID()
    let type: transitOpitions
}

let avalilableTransitTypes: [transitTypes] = [
    transitTypes(type: .all),
    transitTypes(type: .lowSpeedRail),
    transitTypes(type: .highSpeedRail),
    transitTypes(type: .bus),
    transitTypes(type: .scooter),
    transitTypes(type: .plane)
]
