//
//  Notices.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/20/25.
//

import Foundation
import SwiftUI

enum IncidentNoticeType : String, Codable, Equatable {
    case technicalProblem
    case strike
    case demonstration
    case accident
    case weather
    case maintenance
    case construction
    case policeActivity
    case medicalEmergency
    case other
    
    init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let rawValue = try container.decode(String.self)
            self = IncidentNoticeType(rawValue: rawValue) ?? .other
    }
}

enum IncidentEffectType:  String, Codable, Equatable {
    case cancelledService
    case reducedService
    case additionalService
    case modifiedService
    case delays
    case detour
    case stopMoved
    case other
    
    init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let rawValue = try container.decode(String.self)
            self = IncidentEffectType(rawValue: rawValue) ?? .other
    }
}

let noticeIcons = [IncidentNoticeType : String] (
    uniqueKeysWithValues: [
        (.technicalProblem, "wrench.fill"),
        (.strike, "exclamationmark.triangle.fill"),
        (.demonstration, "person.3.fill"),
        (.accident, "car.fill"),
        (.weather, "cloud.sun.rain.fill"),
        (.maintenance, "hammer.fill"),
        (.construction, "constructionsite.fill"),
        (.policeActivity, "shield.lefthalf.fill"),
        (.medicalEmergency, "cross.fill"),
        (.other, "info.circle.fill")
    ]
)

let noticeColors = [IncidentNoticeType : Color] (
    uniqueKeysWithValues: [
        (.technicalProblem, Color.yellow),
        (.maintenance, Color.yellow),
        (.construction, Color.yellow),
        (.strike, Color.orange),
        (.demonstration, Color.orange),
        (.policeActivity, Color.orange),
        (.accident, Color.red),
        (.medicalEmergency, Color.red),
        (.weather, Color.blue),
        (.other, Color.gray)
    ]
)
