//
//  MapPageViewModel.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/9/25.
//

internal import Combine
import CoreLocation
import Foundation
import MapKit
import Polyline
import SwiftUI
import _MapKit_SwiftUI

func calculateCenter(locationA: Location, locationB: Location)
    -> CLLocationCoordinate2D
{
    // Calculate the midpoint between two coordinates
    let midLatitude = (locationA.lat + locationB.lat) / 2
    let midLongitude = (locationA.lng + locationB.lng) / 2
    return CLLocationCoordinate2D(
        latitude: midLatitude,
        longitude: midLongitude
    )
}

func calculateLongitudeDelta(locationA: Location, locationB: Location) -> Double
{
    let delta = abs(locationA.lng - locationB.lng)
    return delta * 1.5  // Add some padding
}

func calculateLatitudeDelta(locationA: Location, locationB: Location) -> Double
{
    let delta = abs(locationA.lat - locationB.lat)
    return delta * 1.5  // Add some padding
}

func determinePolyLineColor(transportationType: TransportationModes) -> Color {
    switch transportationType {
    case .HIGH_SPEED_RAIL:
        return .blue
    case .LOW_SPEED_RAIL:
        return .green
    case .METRO:
        return .orange
    case .BUS:
        return .yellow
    case .FERRY:
        return .blue
    case .WALKING:
        return .pink
    case .FLIGHT:
        return .purple
    }
}

final class MapPageViewModel: ObservableObject {
    @Published var mapCameraCenter: MapCameraPosition
    @Published var polylines: [PolyLineModel] = []
    private var decodeTask: Task<Void, Never>?

    init(route: RouteResponse) {
        let center = calculateCenter(
            locationA: route.departureLocation,
            locationB: route.arrivalLocation
        )
        let longitudeDelta = calculateLongitudeDelta(
            locationA: route.departureLocation,
            locationB: route.arrivalLocation
        )
        let latitudeDelta = calculateLatitudeDelta(
            locationA: route.departureLocation,
            locationB: route.arrivalLocation
        )
        self.mapCameraCenter = MapCameraPosition.region(
            MKCoordinateRegion(
                center: center,
                span: MKCoordinateSpan(
                    latitudeDelta: latitudeDelta,
                    longitudeDelta: longitudeDelta
                )
            )
        )
    }

    func decodePolyLine(_ route: RouteResponse) {
        decodeTask?.cancel()
        decodeTask = Task {
            var polyLineRoute: [PolyLineModel] = []
            for segment in route.steps {
                if let polylineString = segment.polyline {
                    let coordinates = decodePolylineSegment(polylineString)
                    polyLineRoute
                        .append(
                            PolyLineModel(
                                polyLineColor: determinePolyLineColor(
                                    transportationType: segment
                                        .transportationMode
                                ),
                                polylineCoordinates: coordinates
                            )
                        )
                }
            }
            await MainActor.run {
                self.polylines = polyLineRoute
            }
        }
    }

    func decodePolylineSegment(_ polyline: String) -> [CLLocationCoordinate2D] {
        guard
            let polyLineCordinates = Polyline(encodedPolyline: polyline)
                .coordinates
        else {
            return []
        }
        return polyLineCordinates
    }
}
