//
//  Errors.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/8/25.
//

import Foundation

enum RouteFetchErrors : Error {
    case invalidCoordinates
    case invalidURL
    case invalidCredentials
    case requestFailed
    case invalidResponse
    case decodingError
    case noRoutesFound
}

enum LocationEntryErrors : Error {
    case invalidPlaceID
    case coordinateFetchFailed
}

enum GooglePlacesAutoCompleteErrors : Error {
    case invalidRequest
}
