//
//  DefaultDetailInteractor.swift
//  meteo_app
//
//  Created by Alexandre Jegouic on 10/12/2019.
//  Copyright © 2019 Alexandre Jegouic. All rights reserved.
//

import Foundation

public class DefaultDetailInteractor: DetailInteractor {
    private var delegate: DetailDelegate?
    private var dataId: String = ""
    private var model = DetailViewModel.initialized

    public init() {}

    public func setWeatherDataId(_ dataId: String) {
        self.dataId = dataId
    }

    public func start(delegate: DetailDelegate) {
        self.delegate = delegate
        self.dataId = weatherDataId
        AppDelegate.modelManager.add(self)
    }

    public func stop() {
        delegate = nil
        AppDelegate.modelManager.remove(self)
    }
}

extension DefaultDetailInteractor: WeatherDataListener {
    public var id: String { return "DefaultDetailInteractor" }

    public var weatherDataId: String {
        return dataId
    }

    public func updatedWeatherData(weatherData: WeatherData) {
        let newModel = DetailViewModel(
            title: "Detail",
            temperature1: DataView.Model(title: "2m", data: "\(weatherData.temperature.twoM)"),
            temperature2: DataView.Model(title: "sol", data: "\(weatherData.temperature.sol)"),
            humidite: DataView.Model(title: "2m", data: "\(weatherData.humidite.twoM)"),
            pression: DataView.Model(title: "Sea level", data: "\(weatherData.pression.seaLevel)")
        )
        if newModel != model {
            model = newModel
            DispatchQueue.main.async { [weak self] in
                self?.delegate?.update(newModel)
            }
        }
    }
}
