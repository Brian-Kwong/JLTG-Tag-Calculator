//
//  APINetworkManager.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/7/25.
//

import Foundation
import _ConfidentialKit

final class APINetworkManager {
    static let shared = APINetworkManager()
    private let firebaseBaseFunctionURLString = ObfuscatedLiterals.$apiURL
    private let urlSession : URLSession
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.urlCache = URLCache(memoryCapacity: 20_000_000, diskCapacity: 100_000_000)
        self.urlSession = URLSession(configuration: configuration)
    }
    
    func getRoute(
        from origin: UserPlaceEntry,
        destination: UserPlaceEntry,
        departureDate: Date,
        withCache: Bool = true
    ) async throws -> [RouteResponse] {
        guard origin.coordinate != nil,
            destination.coordinate != nil
        else {
            throw RouteFetchErrors.invalidCoordinates
        }
        guard !firebaseBaseFunctionURLString.isEmpty else {
            throw RouteFetchErrors.invalidURL
        }
        guard
            let requestURL = URL(
                string:
                    "\(firebaseBaseFunctionURLString)/calculateRoute?originCoord=\(origin.coordinate!.latitude),\(origin.coordinate!.longitude)&destinationCoord=\(destination.coordinate!.latitude),\(destination.coordinate!.longitude)&departureTime=\(convertToISO8601DateString(date: departureDate))"
            )
        else {
            throw RouteFetchErrors.invalidURL
        }
        URLSession.shared.configuration.timeoutIntervalForRequest = 30
        URLSession.shared.configuration.timeoutIntervalForResource = 60
        var urlRequest = URLRequest(url: requestURL)
        guard let appCheckToken = await getFirebaseToken() else {
            throw RouteFetchErrors.invalidCredentials
        }
        urlRequest.setValue(
            "\(appCheckToken)",
            forHTTPHeaderField: "X-Firebase-AppCheck"
        )
        urlRequest.cachePolicy = withCache ? .returnCacheDataElseLoad : .reloadIgnoringLocalCacheData
        let (data, response) = try await urlSession.data(for: urlRequest)
        guard let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode == 200
        else {
            switch (response as? HTTPURLResponse)?.statusCode {
            case 401, 403:
                throw RouteFetchErrors.invalidCredentials
            case 404:
                throw RouteFetchErrors.noRoutesFound
            default:
                throw RouteFetchErrors.invalidResponse
            }
        }
        do {
            let jsonDecoder = JSONDecoder()
            let routeResponse = try jsonDecoder.decode(
                [RouteResponse].self,
                from: data
            )
            return routeResponse
        } catch {
            throw RouteFetchErrors.decodingError
        }
    }
}
