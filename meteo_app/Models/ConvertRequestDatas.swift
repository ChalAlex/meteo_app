//
//  ConvertRequestDatas.swift
//  meteo_app
//
//  Created by Alexandre Jegouic on 11/12/2019.
//  Copyright © 2019 Alexandre Jegouic. All rights reserved.
//

import Foundation

public enum Parsing :Error {
    case unknownType
    case missingData
    case wrongValueType
}

public enum DecodeRequestData {
    private static let statusJsonKey = "request_state"
    private static let requestKey = "request_key"

    public static func weatherDatas(_ requestData: Data) throws -> RequestData {
        let jsonDecoder = JSONDecoder()
        let parsedData = try jsonDecoder.decode([String: RequestPossibleData].self, from: requestData)

        let status = try retrieveStatus(parsedData: parsedData)
        let requestKey = try retrieveRequestKey(parsedData: parsedData)

        return RequestData(
            status: status,
            requestKey: requestKey,
            weatherDatas: retrieveWeatherDatas(parsedData: parsedData)
        )
    }

    private static func retrieveStatus(parsedData: [String: RequestPossibleData]) throws -> Int {
        guard let statusValue = parsedData[statusJsonKey] else {
            NSLog("No status value inside ParsedJSon")
            throw Parsing.missingData
        }
        if case let RequestPossibleData.int(status) = statusValue {
            return status
        } else {
            NSLog("Status value is not an int value")
            throw Parsing.wrongValueType
        }
    }

    private static func retrieveRequestKey(parsedData: [String: RequestPossibleData]) throws -> String {
        guard let requestKeyValue = parsedData[requestKey] else {
            NSLog("No request key value inside ParsedJSon")
            throw Parsing.missingData
        }
        if case let RequestPossibleData.string(key) = requestKeyValue {
            return key
        } else {
            NSLog("request key is not a String value")
            throw Parsing.wrongValueType
        }
    }

    private static func retrieveWeatherDatas(parsedData: [String: RequestPossibleData]) -> [String: WeatherData] {
        var weatherDatas =  [String: WeatherData]()
        parsedData.forEach { key, value in
            if case let RequestPossibleData.weatherData(weatherData) = value {
                weatherDatas[key] = weatherData
            }
        }
        return weatherDatas
    }
}

fileprivate enum RequestPossibleData: Decodable {
    case int(Int)
    case string(String)
    case weatherData(WeatherData)

    init(from decoder: Decoder) throws {
        if let int = try? decoder.singleValueContainer().decode(Int.self) {
            self = .int(int)
            return
        }

        if let string = try? decoder.singleValueContainer().decode(String.self) {
            self = .string(string)
            return
        }

        if let weatherData = try? decoder.singleValueContainer().decode(WeatherData.self) {
            self = .weatherData(weatherData)
            return
        }
        throw Parsing.unknownType
    }
}
