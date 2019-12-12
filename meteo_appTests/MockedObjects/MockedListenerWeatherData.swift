//
//  MockedListenerWeatherData.swift
//  meteo_appTests
//
//  Created by Alexandre Jegouic on 12/12/2019.
//  Copyright © 2019 Alexandre Jegouic. All rights reserved.
//

import Foundation
@testable import meteo_app

public class MockedListenerWeatherData: WeatherDataListener {
    private let called: () -> Void

    public var id: String {
        return "MockedListenerWeatherData"
    }
    public var weatherDataId: String {
        return "2019-12-11 10:00:00"
    }

    public init(called: @escaping () -> Void) {
        self.called = called
    }

     public func updatedWeatherData(weatherData: WeatherData) {
        called()
    }
}
