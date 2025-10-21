//
//  RouteDeparturesResponseModel.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/14/25.
//

import Foundation

struct RouteDepartureLine: Hashable, Codable, Identifiable {
    var id: UUID { UUID() }
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

    static func == (lhs: RouteDepartureLine, rhs: RouteDepartureLine) -> Bool {
        return lhs.mode == rhs.mode && lhs.name == rhs.name
            && lhs.color == rhs.color
            && lhs.transitLineFinalDestination
                == rhs.transitLineFinalDestination
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(mode)
        hasher.combine(name)
        hasher.combine(color)
        hasher.combine(transitLineFinalDestination)
    }
}

struct RouteDeparture: Hashable, Codable, Identifiable {
    var id: UUID { UUID() }
    var time: String
    var delay: Int?
    var status: String?
    var platform: String?
    var line: RouteDepartureLine

    private enum CodingKeys: String, CodingKey {
        case time,
            delay,
            status,
            platform,
            line
    }

    static func == (lhs: RouteDeparture, rhs: RouteDeparture) -> Bool {
        return lhs.time == rhs.time && lhs.delay == rhs.delay
            && lhs.status == rhs.status && lhs.platform == rhs.platform
            && lhs.line == rhs.line
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(time)
        hasher.combine(delay)
        hasher.combine(status)
        hasher.combine(platform)
        hasher.combine(line)
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
    var id: UUID { UUID() }
    var station: RouteDepartureStation
    var departures: [RouteDeparture]
    var numberOfLines: Int {
        let uniqueLines = Set(departures.map { $0.line.name ?? "" })
        return uniqueLines.count
    }
    var earliestDepartureTime: Date? {
        convertStringToDate(
            dateString: departures.min(by: { dep1, dep2 in
                guard let date1 = ISO8601DateFormatter().date(from: dep1.time),
                    let date2 = ISO8601DateFormatter().date(from: dep2.time)
                else {
                    return false
                }
                return date1 < date2
            })?.time ?? ""
        )
    }
    private enum CodingKeys: String, CodingKey {
        case station,
            departures
    }
}
