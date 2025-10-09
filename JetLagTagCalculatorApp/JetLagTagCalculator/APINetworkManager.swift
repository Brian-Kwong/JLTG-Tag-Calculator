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
    func getRoute(
        from origin: UserPlaceEntry,
        destination: UserPlaceEntry,
    ) async throws -> [RouteResponse] {
        if (origin.coordinate == nil) || (destination.coordinate == nil) {
            throw RouteFetchErrors.invalidURL
        }
        if firebaseBaseFunctionURLString.isEmpty {
            throw RouteFetchErrors.invalidURL
        }
        let requestURL = URL(
            string:
                "\(firebaseBaseFunctionURLString)/calculateRoute?originCoord=\(origin.coordinate!.latitude),\(origin.coordinate!.longitude)&destinationCoord=\(destination.coordinate!.latitude),\(destination.coordinate!.longitude)"
        )
        if requestURL == nil {
            throw RouteFetchErrors.invalidURL
        }
        URLSession.shared.configuration.timeoutIntervalForRequest = 30
        URLSession.shared.configuration.timeoutIntervalForResource = 60
        var urlRequest = URLRequest(url: requestURL!)
        guard let appCheckToken = await getFirebaseToken() else {
            throw RouteFetchErrors.invalidCredentials
        }
        urlRequest.setValue(
            "\(appCheckToken)",
            forHTTPHeaderField: "X-Firebase-AppCheck"
        )
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode == 200
        else {
            throw RouteFetchErrors.invalidResponse
        }
        do {
            let jsonDecoder = JSONDecoder()
            print("Data received: \(String(data: data, encoding: .utf8) ?? "N/A")")
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
