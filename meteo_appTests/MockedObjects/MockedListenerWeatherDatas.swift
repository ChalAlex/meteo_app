//
//  MockedListenerDatas.swift
//  meteo_appTests
//
//  Created by Alexandre Jegouic on 12/12/2019.
//  Copyright © 2019 Alexandre Jegouic. All rights reserved.
//

import Foundation
@testable import meteo_app

public class MockedListenerWeatherDatas: WeatherDatasListener {
    private let called: () -> Void

    public var id: String {
        return "MockedListenerWeatherDatas"
    }

    public init(called: @escaping () -> Void) {
        self.called = called
    }

    public func updatedWeatherDatas(weatherDatas: [String : WeatherData]) {
        called()
    }
}
