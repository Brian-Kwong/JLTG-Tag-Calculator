//
//  Icons.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/9/25.
//

import Foundation
import SwiftUI
import GooglePlacesSwift

func findIcon(for place: AutocompletePlaceSuggestion) -> String {
    for placeType in place.types {
        switch placeType.rawValue {
        case "city_hall":
            return "building.2.fill"
        case "airport", "international_airport", "airstrip":
            return "airplane.departure"
        case "train_station", "subway_station", "light_rail_station":
            return "tram.fill"
        case "bus_station", "bus_stop":
            return "bus.fill"
        case "taxi_stand":
            return "car.fill"
        case "ferry_terminal":
            return "ferry.fill"
        default:
            continue
        }
    }
    return "mappin.and.ellipse"
}

func determineRouteLargeOcom(route: RouteResponse) -> AnyView {
    var transportationModeTypeCount: [TransportationModes: Int] = route.steps
        .reduce(
            into: [:]
        ) { counts, step in
            counts[step.transportationMode, default: 0] += 1
        }
    // Set walking as last resort
    transportationModeTypeCount[.WALKING, default: 0] = 0
    let transportationMode =
        transportationModeTypeCount.max {
            a,
            b in
            a.value < b.value
                || (a.value == b.value
                    && TransportationModes.allCases.firstIndex(of: a.key)!
                        > TransportationModes.allCases.firstIndex(of: b.key)!)
        }?.key ?? .WALKING
    return createIcon(transportationMode: transportationMode)
}

func createIcon(transportationMode : TransportationModes,iconSize : CGFloat = 40, iconPadding : CGFloat = 20) -> AnyView {
    var icon: AnyView
    var color: Color
    switch transportationMode {
    case .HIGH_SPEED_RAIL:
        icon = AnyView(HighSpeedTrain())
        color = .blue
    case .LOW_SPEED_RAIL:
        icon = AnyView(LowSpeedRail())
        color = .green
    case .METRO:
        icon = AnyView(MetroTrain())
        color = .orange
    case .BUS:
        icon = AnyView(BusIcon())
        color = .yellow
    case .FERRY:
        icon = AnyView(FerryIcon())
        color = .blue
    case .WALKING:
        icon = AnyView(WalkingIcon())
        color = .pink
    case .FLIGHT:
        icon = AnyView(Airplane())
        color = .purple
    }
    return AnyView(
        icon.frame(
            width: iconSize,
            height: iconSize,
            alignment: .center
        ).padding(iconPadding).background(color.opacity(0.2)).cornerRadius(50)
    )
}

func determineRouteLogo(transportationMode: TransportationModes) -> AnyView {
    switch transportationMode {
    case .HIGH_SPEED_RAIL:
        return AnyView(RouteLine(icon: HighSpeedTrain(), iconColor: .blue))
    case .LOW_SPEED_RAIL:
        return AnyView(RouteLine(icon: LowSpeedRail(), iconColor: .green))
    case .METRO:
        return AnyView(RouteLine(icon: MetroTrain(), iconColor: .orange))
    case .BUS:
        return AnyView(RouteLine(icon: BusIcon(), iconColor: .yellow))
    case .FERRY:
        return AnyView(RouteLine(icon: FerryIcon(), iconColor: .blue))
    case .WALKING:
        return AnyView(RouteLine(icon: WalkingIcon(), iconColor: .pink))
    case .FLIGHT:
        return AnyView(RouteLine(icon: Airplane(), iconColor: .purple))
    }
}
