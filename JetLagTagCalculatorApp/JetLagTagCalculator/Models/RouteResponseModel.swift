//
//  RouteResponseModel.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/5/25.
//

import Foundation

enum TransportationModes: String, Codable, Hashable, CaseIterable, Identifiable
{
    case HIGH_SPEED_RAIL = "HIGH_SPEED_RAIL"
    case LOW_SPEED_RAIL = "LOW_SPEED_RAIL"
    case METRO = "METRO"
    case BUS = "BUS"
    case FERRY = "FERRY"
    case FLIGHT = "FLIGHT"
    case WALKING = "WALKING"

    var id: Self { self }
}

struct Location: Hashable, Codable {
    var name: String
    var lat: Double
    var lng: Double

    static func == (lhs: Location, rhs: Location) -> Bool {
        return lhs.name == rhs.name && lhs.lat == rhs.lat && lhs.lng == rhs.lng
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(lat)
        hasher.combine(lng)
    }
}

struct ResponseIncident: Hashable, Codable, Identifiable {
    let id = UUID()
    var summary: String?
    var description: String?
    var type: IncidentNoticeType
    var effect: IncidentEffectType
    var validFrom: String?
    var validUntil: String?
    var url: String?

    private enum CodingKeys: String, CodingKey {
        case summary,
            description,
            type,
            effect,
            validFrom,
            validUntil,
            url
    }
}

struct ResponseStep: Hashable, Codable, Identifiable {
    let id = UUID()
    var transportationMode: TransportationModes
    var startLocation: Location
    var endLocation: Location
    var duration: Int
    var distance: Int
    var polyline: String?
    var journeyCost: Int
    var lineName: String?
    var vehicleType: String?
    var departureTime: String?
    var arrivalTime: String?
    var numStops: Int?
    var transitLineFinalDestination: String?

    private enum CodingKeys: String, CodingKey {
        case transportationMode,
            startLocation,
            endLocation,
            duration,
            distance,
            polyline,
            journeyCost,
            lineName,
            vehicleType,
            departureTime,
            arrivalTime,
            numStops,
            transitLineFinalDestination
    }
}

struct RouteResponse: Hashable, Codable, Identifiable {
    let id = UUID()
    var departureLocation: Location
    var arrivalLocation: Location
    var departureDate: String
    var arrivalDate: String
    var departureTime: String
    var arrivalTime: String
    var totalDuration: Int
    var totalDistance: Double
    var totalCost: Int
    var numTransfers: Int
    var numSteps: Int
    var steps: [ResponseStep]
    var incidents: [ResponseIncident]?

    private enum CodingKeys: String, CodingKey {
        case departureLocation,
            arrivalLocation,
            departureDate,
            arrivalDate,
            departureTime,
            arrivalTime,
            totalDuration,
            totalDistance,
            totalCost,
            numTransfers,
            numSteps,
            steps,
            incidents
    }
}
