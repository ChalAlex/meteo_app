//
//  OfflineMode.swift
//  meteo_app
//
//  Created by Alexandre Jegouic on 13/12/2019.
//  Copyright © 2019 Alexandre Jegouic. All rights reserved.
//

import Foundation

public enum DataSaver {
    private static let userDefaultId = "savedData"

    static func save(data: RequestData) {
        let encoder = JSONEncoder()
        do {
            let encoded = try encoder.encode(data)
            UserDefaults.standard.set(encoded, forKey: userDefaultId)
        } catch {
            NSLog("Can't encode RequestData")
        }
    }

    static func retrieve() -> RequestData? {
        if let encoded = UserDefaults.standard.data(forKey: userDefaultId) {
            let decoder = JSONDecoder()
            do {
                return try decoder.decode(RequestData.self, from: encoded)
            } catch {
                NSLog("Can't decode RequestData")
            }
        }
        return nil
    }
}
