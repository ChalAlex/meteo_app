//
//  WeatherRequest.swift
//  meteo_app
//
//  Created by Alexandre Jegouic on 11/12/2019.
//  Copyright © 2019 Alexandre Jegouic. All rights reserved.
//

import Foundation


public struct WeatherData: Codable, Equatable {
    public let temperature: Temperature
    public let pression: Pression
    public let humidite: Humidite
}

public struct Temperature: Codable, Equatable {
    public let twoM: Double
    public let sol: Double

    internal enum CodingKeys: String, CodingKey {
        case twoM   = "2m"
        case sol    = "sol"
    }
}

public struct Pression: Codable, Equatable {
    public let seaLevel: Double

    internal enum CodingKeys: String, CodingKey {
        case seaLevel = "niveau_de_la_mer"
    }
}

public struct Humidite: Codable, Equatable {
    public let twoM: Double

    internal enum CodingKeys: String, CodingKey {
        case twoM   = "2m"
    }
}
