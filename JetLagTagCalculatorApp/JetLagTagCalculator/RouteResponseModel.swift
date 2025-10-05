//
//  RouteResponseModel.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/5/25.
//

import Foundation

enum TransportationModes: Decodable, Encodable {
    case HIGH_SPEED_RAIL
    case LOW_SPEED_RAIL
    case METRO
    case BUS
    case FERRY
    case FLIGHT
    case WALKING
}

struct Location : Hashable, Decodable, Encodable {
    var name: String;
    var lat: Double;
    var lng: Double;
}

struct ResponseStep : Hashable, Decodable, Encodable {
    var transportationMode: TransportationModes;
    var startLocation: Location
    var endLocation: Location
    var duration: Int
    var journeyCost: Int
    var lineNam: String?
    var vehicleName: String?
    var departureTime: String?
    var arrivalTime: String?
    var numStops: String?
    var transitLineFinalDestination: String?
}

struct RouteResponse: Hashable, Decodable, Encodable {
    var departureLocation: Location
    var arrivalLocation: Location
    var departureDate: String
    var arrivalDate: String
    var departureTime: String
    var arrivalTime: String
    var totalDuration: Int
    var totalCost: Int
    var numTransfers: Int
    var numSteps: Int
    var steps: [ResponseStep]
}
    
