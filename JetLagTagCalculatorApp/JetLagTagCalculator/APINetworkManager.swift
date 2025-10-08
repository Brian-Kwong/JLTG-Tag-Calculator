//
//  APINetworkManager.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/7/25.
//

import Foundation

func getRoute(
    from origin: UserPlaceEntry,
    destination: UserPlaceEntry,
    completion: @escaping (Result<RouteResults, Error>) -> Void
) {
    guard let originCoordinate = origin.coordinate,
        let destinationCoordinate = destination.coordinate
    else {
        completion(
            Result<
                RouteResults,
                Error
            >
            .failure(
                NSError(
                    domain: "Invalid coordinates",
                    code: 0,
                    userInfo: nil
                )
            )
        )
        return
    }
}
