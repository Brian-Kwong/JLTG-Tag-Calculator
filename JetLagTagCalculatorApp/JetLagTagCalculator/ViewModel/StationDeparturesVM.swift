//
//  StationDeparturesVM.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/19/25.
//

internal import Combine
import Foundation

enum DeparturesSortByOptions: String, CaseIterable, Identifiable {
    case lines = "tram.fill"
    case earliestDepartures = "arrow.up.circle"
    case latestDepartures = "arrow.down.circle"
    case platform = "number"
    case destination = "mappin.and.ellipse"

    var id: String { self.rawValue }
}

final class StationDeparturesViewModel: ObservableObject {
    @Published var station: RouteDeparturesResponse
    @Published var sortByOption: DeparturesSortByOptions = .earliestDepartures {
        didSet {
            sortDepartures(sortBy: sortByOption)
        }
    }

    init(station: RouteDeparturesResponse) {
        self.station = station
    }

    func sortDepartures(sortBy: DeparturesSortByOptions) {
        switch sortBy {
        case .earliestDepartures:
            station.departures
                .sort {
                    convertStringToDate(dateString: $0.time) ?? Date()
                        < convertStringToDate(dateString: $1.time) ?? Date()
                }
        case .latestDepartures:
            station.departures.sort {
                convertStringToDate(dateString: $0.time) ?? Date()
                    > convertStringToDate(dateString: $1.time) ?? Date()
            }
        case .lines:
            station.departures.sort { $0.line.name ?? "" < $1.line.name ?? "" }
        case .platform:
            station.departures.sort {
                ($0.platform ?? "") < ($1.platform ?? "")
            }
        case .destination:
            station.departures.sort {
                $0.line.transitLineFinalDestination ?? "" < $1.line
                    .transitLineFinalDestination ?? ""
            }
        }
    }
}
