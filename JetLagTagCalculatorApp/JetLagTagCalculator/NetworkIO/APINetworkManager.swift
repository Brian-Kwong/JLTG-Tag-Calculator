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
    
    private func fetchResource(url : URL, withCache : Bool) async throws -> Data {
        guard !firebaseBaseFunctionURLString.isEmpty else {
            throw RouteFetchErrors.invalidURL
        }
        URLSession.shared.configuration.timeoutIntervalForRequest = 30
        URLSession.shared.configuration.timeoutIntervalForResource = 60
        var urlRequest = URLRequest(url: url)
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
            URLCache.shared.removeCachedResponse(for: urlRequest)
            switch (response as? HTTPURLResponse)?.statusCode {
            case 401, 403:
                throw RouteFetchErrors.invalidCredentials
            case 404:
                throw RouteFetchErrors.noRoutesFound
            default:
                print("Status code \((response as? HTTPURLResponse)?.statusCode ?? -1))")
                throw RouteFetchErrors.invalidResponse
            }
        }
        return data
    }
    
    private func jsonDecoder<T : Decodable>(data : Data, decodeType: T.Type) async throws -> [T]? where T : Decodable {
        do {
            let jsonDecoder = JSONDecoder()
            let departuresData = try jsonDecoder.decode(
                [T].self,
                from: data
            )
            return departuresData
        } catch {
            throw RouteFetchErrors.decodingError
        }
    }
    
    func getRoute(
        from origin: UserPlaceEntry,
        destination: UserPlaceEntry,
        departureDate: Date,
        modesOfTransport: Set<TransportationModes>,
        withCache: Bool = true
    ) async throws -> [RouteResponse] {
        guard origin.coordinate != nil,
            destination.coordinate != nil
        else {
            throw RouteFetchErrors.invalidCoordinates
        }
        guard let disallowedModesOfTransport = Set(TransportationModes.allCases).subtracting( modesOfTransport).map({ $0.rawValue }).joined(separator: ",") as String? else {
            throw RouteFetchErrors.invalidTransportMode
        }
        guard
            let requestURL = URL(
                string:
                    "\(firebaseBaseFunctionURLString)/calculateRoute?originCoord=\(origin.coordinate!.latitude),\(origin.coordinate!.longitude)&destinationCoord=\(destination.coordinate!.latitude),\(destination.coordinate!.longitude)&departureTime=\(convertToISO8601DateString(date: departureDate))&avoidModes=\(disallowedModesOfTransport)"
            )
        else {
            throw RouteFetchErrors.invalidURL
        }
        do {
            let data = try await fetchResource(url: requestURL, withCache: withCache)
            let routeData = try await jsonDecoder(data: data, decodeType: RouteResponse.self)
            if let routeData {
                return routeData
            } else {
                throw RouteFetchErrors.noRoutesFound
            }
        } catch {
            throw error
        }
    }
    
    func getDepartures(
        location : UserPlaceEntry,
        radius : String,
        dateTime: Date,
        modeOfTransport: Set<TransportationModes>,
        withCache: Bool = true
    ) async throws -> [RouteDeparturesResponse] {
        guard location.coordinate != nil else {
            throw RouteFetchErrors.invalidCoordinates
        }
        guard !firebaseBaseFunctionURLString.isEmpty else {
            throw RouteFetchErrors.invalidURL
        }
        guard let disallowedModesOfTransport = Set(TransportationModes.allCases).subtracting( modeOfTransport).map({ $0.rawValue }).joined(separator: ",") as String? else {
            throw RouteFetchErrors.invalidTransportMode
        }
        guard
            let requestURL = URL(
                string:
                    "\(firebaseBaseFunctionURLString)/departures?coordinates=\(location.coordinate!.latitude),\(location.coordinate!.longitude)&departureTime=\(convertToISO8601DateString(date: dateTime))&radius=\(radius)&avoidModes=\(disallowedModesOfTransport)"
            )
        else {
            throw RouteFetchErrors.invalidURL
        }
        do {
            let data = try await fetchResource(url: requestURL, withCache: withCache)
            let departuresData = try await jsonDecoder(data: data, decodeType: RouteDeparturesResponse.self)
            if let departuresData {
                return departuresData
            } else {
                throw RouteFetchErrors.noDeparturesFound
            }
        } catch {
            throw error
        }
    }
}
