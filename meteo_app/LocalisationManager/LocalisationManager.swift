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
    private var askAccessCompletion: (() -> Void)?
    private var localisationCompletion: ((Double, Double) -> Void)?

    public override init() {
        super.init()
        locationManager.delegate = self
    }

    @discardableResult
    public func localisation(completion: @escaping (Double, Double) -> Void) -> Bool {
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
            locationManager.startUpdatingLocation()
            return true
        } else {
            return false
        }
    }

    public func askAccess(completion: @escaping () -> Void) {
        locationManager.requestWhenInUseAuthorization()
        askAccessCompletion = completion
    }
}

extension LocalisationManager: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        /// Needed to be called only once after an localisation function.
        localisationCompletion?(location.coordinate.latitude, location.coordinate.longitude)
        localisationCompletion = nil
    }

    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        /// Needed to be called only once after an askAccess configuration.
        askAccessCompletion?()
        askAccessCompletion = nil
    }
}
