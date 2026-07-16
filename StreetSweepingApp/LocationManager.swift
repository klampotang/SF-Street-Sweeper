//
//  LocationManager.swift
//  StreetSweepingApp
//
//  Created by Kelly lampotang on 7/15/26.
//

import CoreLocation
internal import Combine

@MainActor
final class LocationManager: NSObject, ObservableObject {
    @Published private(set) var authorizationStatus: CLAuthorizationStatus
    @Published private(set) var currentLocation: CLLocation?
    
    private let manager = CLLocationManager()

    override init() {
        authorizationStatus = manager.authorizationStatus
        
        super.init()
        
        manager.delegate = self
        
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.activityType = .automotiveNavigation
        
        manager.distanceFilter = 10
    }
    
    func start() {
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            manager.startUpdatingLocation()
        case .denied, .restricted:
            manager.stopUpdatingLocation()
        @unknown default:
            manager.stopUpdatingLocation()
        }
    }
    
    func stop() {
        manager.stopUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    nonisolated func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let newStatus = manager.authorizationStatus
        
        Task { @MainActor in
            authorizationStatus = newStatus
            switch newStatus {
            case .authorizedWhenInUse, .authorizedAlways:
                manager.startUpdatingLocation()
                
            case .denied, .restricted:
                manager.stopUpdatingLocation()
                
            case .notDetermined:
                break
                
            @unknown default:
                manager.stopUpdatingLocation()
            }
        }
    }
    
    nonisolated func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newestLocation = locations.last else {
            return
        }
        
        Task { @MainActor in
            currentLocation = newestLocation
        }
    }
}
