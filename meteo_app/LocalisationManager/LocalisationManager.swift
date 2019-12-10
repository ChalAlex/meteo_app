//
//  LocalisationManager.swift
//  meteo_app
//
//  Created by Alexandre Jegouic on 10/12/2019.
//  Copyright © 2019 Alexandre Jegouic. All rights reserved.
//

import CoreLocation

public enum LocalisationState {
    case ask
    case access
    case denied

    static func get() -> LocalisationState {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            return .ask
        case .authorizedAlways, .authorizedWhenInUse:
            return .access
        case .denied, .restricted:
            return .denied
        }
    }
}

public class LocalisationManager: NSObject {
    private let locationManager = CLLocationManager()

    public private(set) var latitude: Double?
    public private(set) var longitude: Double?

    @discardableResult
    public func activateLocalisation() -> Bool {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
            locationManager.startUpdatingLocation()
            return true
        } else {
            return false
        }
    }
}

extension LocalisationManager: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        latitude = locations.first?.coordinate.latitude
        longitude = locations.first?.coordinate.longitude
    }
}
