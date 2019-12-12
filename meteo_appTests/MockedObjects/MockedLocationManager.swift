//
//  MockedLocationManager.swift
//  meteo_app
//
//  Created by Alexandre Jegouic on 12/12/2019.
//  Copyright © 2019 Alexandre Jegouic. All rights reserved.
//

import Foundation

public class MockedLocalisationManager: LocalisationManager {
    /// custom Localisation for Paris : latitude 48.866667 longitude 2.333333
    public func localisation(completion: @escaping (Double, Double) -> Void) -> Bool {
        completion(48.866667, 2.333333)
        return true
    }
    
    public func askAccess(completion: @escaping () -> Void) {
        completion()
    }
    

}
