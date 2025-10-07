//
//  RouteResponseModel.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/5/25.
//

import Foundation

enum TransportationModes: String, Codable, Hashable, CaseIterable {
    case HIGH_SPEED_RAIL = "HIGH_SPEED_RAIL"
    case LOW_SPEED_RAIL = "LOW_SPEED_RAIL"
    case METRO = "METRO"
    case BUS = "BUS"
    case FERRY = "FERRY"
    case FLIGHT = "FLIGHT"
    case WALKING = "WALKING"
}

struct Location: Hashable, Codable {
    var name: String
    var lat: Double
    var lng: Double
}

struct ResponseStep: Hashable, Codable, Identifiable {
    var id = UUID()
    var transportationMode: TransportationModes
    var startLocation: Location
    var endLocation: Location
    var duration: Int
    var distance: Int
    var polyline: String?
    var journeyCost: Int
    var lineNam: String?
    var vehicleName: String?
    var departureTime: String?
    var arrivalTime: String?
    var numStops: String?
    var transitLineFinalDestination: String?
    
    private enum CodingKeys: String, CodingKey {
        case transportationMode,
             startLocation,
             endLocation,
             duration,
             distance,
             polyline,
             journeyCost,
             lineNam,
             vehicleName,
             departureTime,
             arrivalTime,
             numStops,
             transitLineFinalDestination
    }
}

struct RouteResponse: Hashable, Codable, Identifiable {
    var id = UUID()
    var departureLocation: Location
    var arrivalLocation: Location
    var departureDate: String
    var arrivalDate: String
    var departureTime: String
    var arrivalTime: String
    var totalDuration: Int
    var totalDistance: Int
    var totalCost: Int
    var numTransfers: Int
    var numSteps: Int
    var steps: [ResponseStep]

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
            steps
    }
}
