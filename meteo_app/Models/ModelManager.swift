//
//  ModelManager.swift
//  meteo_app
//
//  Created by Alexandre Jegouic on 11/12/2019.
//  Copyright © 2019 Alexandre Jegouic. All rights reserved.
//

import Foundation

public protocol WeatherDatasListener {
    var id: String { get }
    func updatedWeatherDatas(weatherDatas: [String: WeatherData])
}

public protocol WeatherDataListener {
    var id: String { get }

    var weatherDataId: String { get }
    func updatedWeatherData(weatherData: WeatherData)
}

public protocol ModelManager {
    func add(_ listener: WeatherDatasListener)
    func remove(_ listener: WeatherDatasListener)

    func add(_ listener: WeatherDataListener)
    func remove(_ listener: WeatherDataListener)

    func refreshData(completion: @escaping (Error?) -> Void)
}

public class ImpModelManager: ModelManager {
    private var weatherDatasListener: [WeatherDatasListener] = []
    private var weatherDataListener: [WeatherDataListener] = []
    private var appModel: RequestData? {
        didSet {
            callListenerIfNeeded()
        }
    }

    private let requestManager: RequestManager

    public init(requestManager: RequestManager) {
        self.requestManager = requestManager
    }

    public func add(_ listener: WeatherDatasListener) {
        weatherDatasListener.append(listener)
        if let appModel = appModel {
            listener.updatedWeatherDatas(weatherDatas: appModel.weatherDatas)
        }
    }

    public func remove(_ listener: WeatherDatasListener) {
        weatherDatasListener.removeAll(where: { $0.id == listener.id })
    }

    public func add(_ listener: WeatherDataListener) {
        weatherDataListener.append(listener)
        if let weatherData = appModel?.weatherDatas[listener.weatherDataId] {
            listener.updatedWeatherData(weatherData: weatherData)
        }
    }

    public func remove(_ listener: WeatherDataListener) {
        weatherDataListener.removeAll(where: { $0.id == listener.id })
    }

    public func refreshData(completion: @escaping (Error?) -> Void) {
        requestManager.getWeatherData { [weak self] result in
            switch result {
            case let .success(newData):
                do {
                    self?.appModel = try DecodeRequestData.weatherDatas(newData)
                    completion(nil)
                } catch {
                    completion(error)
                }

            case let .failure(error):
                completion(error)
            }
        }
    }
}

extension ImpModelManager {
    fileprivate func callListenerIfNeeded() {
        guard let appModel = appModel else { return }

        weatherDatasListener.forEach { listener in
            listener.updatedWeatherDatas(weatherDatas: appModel.weatherDatas)
        }
        weatherDataListener.forEach { listener in
            if let weatherData = appModel.weatherDatas[listener.weatherDataId] {
                listener.updatedWeatherData(weatherData: weatherData)
            }
        }
    }
}
