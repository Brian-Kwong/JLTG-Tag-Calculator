//
//  UserLocationManager.swift
//  JetLagTagCalculator
//
//  Created by Brian Kwong on 10/4/25.
//

internal import Combine
import CoreLocation
import Foundation

final class UserLocationManager: NSObject, CLLocationManagerDelegate,
    ObservableObject
{
    
    static var shared = UserLocationManager()
    
    @Published var userLocation: CLLocation?
    
    var allowedLocation: Bool?

    private let locationManager = CLLocationManager()

    func checkAuthAndStartLocationServices() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest  // Get more accurate results
        
        switch locationManager.authorizationStatus {
        case .notDetermined:
            // Not sure ask?
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            // Parental controls
            allowedLocation = false
            print("Location access was restricted or denied.")
        case .authorizedAlways, .authorizedWhenInUse:
            // We have access
            locationManager.startUpdatingLocation()
            userLocation = locationManager.location
            allowedLocation = true
        @unknown default:
            break
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkAuthAndStartLocationServices()
    }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    func stattUpdatingLocation() {
        if allowedLocation != nil {
            if allowedLocation == true {
                locationManager.startUpdatingLocation()
                userLocation = locationManager.location
            } else {
                return
            }
        } else {
            checkAuthAndStartLocationServices()
        }
    }

    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        guard let latestLocation = locations.last else { return }
        userLocation = latestLocation
    }
}
