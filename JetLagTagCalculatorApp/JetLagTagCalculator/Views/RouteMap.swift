//
//  RouteMap.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/9/25.
//

internal import Combine
import CoreLocation
import Foundation
import MapKit
import SwiftUI

struct RouteMap: View {
    let route: RouteResponse
    @StateObject private var mapViewModel: MapPageViewModel
    init(route: RouteResponse) {
        self.route = route
        _mapViewModel = StateObject(
            wrappedValue: MapPageViewModel(route: route)
        )
    }
    var body: some View {
        Map(initialPosition: mapViewModel.mapCameraCenter) {
            if !mapViewModel.polylines.isEmpty {
                ForEach(mapViewModel.polylines) { polyline in
                    MapPolyline(coordinates: polyline.polylineCoordinates)
                        .stroke(polyline.polyLineColor, lineWidth: 4)
                }
            }
            ForEach(route.steps) { step in
                stepAnnotation(
                    lat: step.startLocation.lat,
                    long: step.startLocation.lng,
                    name: step.startLocation.name,
                    endPoints: route.steps.first == step ? true : false
                )
            }
            stepAnnotation(
                lat: route.steps.last!.endLocation.lat,
                long: route.steps.last!.endLocation.lng,
                name: route.steps.last?.endLocation.name ?? "",
                endPoints: true
            )
        }.onAppear {
            mapViewModel.decodePolyLine(route)
        }
    }

    @MapContentBuilder
    private func stepAnnotation(
        lat: Double,
        long: Double,
        name: String,
        endPoints: Bool = false
    ) -> some MapContent {
        Annotation(
            name,
            coordinate: CLLocationCoordinate2D(
                latitude: lat,
                longitude: long,
            )
        ) {
            VStack {
                Circle()
                    .fill(endPoints ? .red : .gray)
                    .frame(
                        width: endPoints ? 20 : 12,
                        height: endPoints ? 20 : 12
                    )
                    .overlay(
                        Circle()
                            .stroke(.white, lineWidth: 2)
                    ).shadow(radius: 3)
                if mapViewModel.mapCameraCenter.region?.span
                    .latitudeDelta ?? 0 < 0.05
                {

                    Text(name)
                        .font(.system(size: TextSizes.caption))
                }
            }
        }
    }
}

#Preview {
    struct RouteMapPagePreviewWrapper: View {
        @StateObject var routeResultsViewModel = RoutesViewModel(
            forPreview: true
        )
        var body: some View {
            if let firstRoute = routeResultsViewModel.routes.first {
                RouteMap(route: firstRoute)
            } else {
                Text("No Route Data")
            }
        }
    }
    return RouteMapPagePreviewWrapper()
}
