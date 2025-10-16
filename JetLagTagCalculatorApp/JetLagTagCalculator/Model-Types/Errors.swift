//
//  Errors.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/8/25.
//

import Foundation

enum RouteFetchErrors : Error {
    case invalidCoordinates
    case invalidTransportMode
    case invalidURL
    case invalidCredentials
    case requestFailed
    case invalidResponse
    case decodingError
    case noRoutesFound
    case noDeparturesFound
}

enum LocationEntryErrors : Error {
    case invalidPlaceID
    case coordinateFetchFailed
}

enum GooglePlacesAutoCompleteErrors : Error {
    case invalidRequest
}
