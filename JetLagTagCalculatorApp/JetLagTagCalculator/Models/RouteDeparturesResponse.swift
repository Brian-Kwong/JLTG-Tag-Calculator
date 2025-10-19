//
//  RouteDeparturesResponseModel.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/14/25.
//

import Foundation

struct RouteDepartureLineHashable: Hashable, Codable, Identifiable {
    var id = UUID()
    var mode: TransportationModes
    var name: String?
    var color: String?
    var transitLineFinalDestination: String?

    private enum CodingKeys: String, CodingKey {
        case mode,
            name,
            color,
            transitLineFinalDestination
    }
}

struct RouteDeparture: Hashable, Codable, Identifiable {
    var id = UUID()
    var time: String
    var delay: Int?
    var status: String?
    var platform: String?
    var line: RouteDepartureLineHashable

    private enum CodingKeys: String, CodingKey {
        case time,
            delay,
            status,
            platform,
            line
    }
}

struct RouteDepartureStation: Hashable, Codable, Identifiable {
    var id: String
    var name: String
    var lat: Double
    var lng: Double
    var type: TransportationModes
    var distance: Double?

    private enum CodingKeys: String, CodingKey {
        case id,
            name,
            lat,
            lng,
            type,
            distance
    }
}

struct RouteDeparturesResponse: Hashable, Codable, Identifiable {
    var id = UUID()
    var station: RouteDepartureStation
    var departures: [RouteDeparture]
    var numberOfLines: Int {
        let uniqueLines = Set(departures.map { $0.line.name ?? "" })
        return uniqueLines.count
    }
    var earliestDepartureTime: Date?  { convertStringToDate(
        dateString: departures.min(by: { dep1, dep2 in
            guard let date1 = ISO8601DateFormatter().date(from: dep1.time),
                let date2 = ISO8601DateFormatter().date(from: dep2.time)
            else {
                return false
            }
            return date1 < date2
        })?.time ?? "")
    }
    private enum CodingKeys: String, CodingKey {
        case station,
            departures
    }
}
