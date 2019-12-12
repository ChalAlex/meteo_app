//
//  meteo_appTests.swift
//  meteo_appTests
//
//  Created by Alexandre Jegouic on 10/12/2019.
//  Copyright © 2019 Alexandre Jegouic. All rights reserved.
//

import XCTest
@testable import meteo_app

class ModelsTests: XCTestCase {

    func testParsing() {
        let bundle = Bundle(for: type(of: self))
        guard let path = bundle.url(forResource: "WeatherRequestMocked", withExtension: "json") else {
            XCTFail()
            return
        }

        do {
            let data = try Data(contentsOf: path)
            let weatherDatas = try DecodeRequestData.weatherDatas(data)
            XCTAssertEqual(weatherDatas.status, 200)
            XCTAssertEqual(weatherDatas.requestKey, "fd543c77e33d6c8a5e218e948a19e487")
            XCTAssertEqual(weatherDatas.weatherDatas.count, 64)

        } catch {
            XCTFail("Can't parse weatherDatas with Jsondecoder, \(error)")
        }
    }

    func testMissingData() {
        let bundle = Bundle(for: type(of: self))
        guard let path = bundle.url(forResource: "MissingDatas", withExtension: "json") else {
            XCTFail()
            return
        }

        do {
            let data = try Data(contentsOf: path)
            _ = try DecodeRequestData.weatherDatas(data)
            XCTFail("We must have missingData error")
        } catch {
            if case Parsing.missingData = error  {
                // succedd
            } else {
                 XCTFail("We retrieve the wrong error type, \(error)")
            }
        }
    }

    func testWrongValueType() {
        let bundle = Bundle(for: type(of: self))
        guard let path = bundle.url(forResource: "WrongValue", withExtension: "json") else {
            XCTFail()
            return
        }

        do {
            let data = try Data(contentsOf: path)
            _ = try DecodeRequestData.weatherDatas(data)
            XCTFail("We must have missingData error")
        } catch {
            if case Parsing.wrongValueType = error  {
                // succedd
            } else {
                XCTFail("We retrieve the wrong error type, \(error)")
            }
        }
    }

    func testDataSaverEncodeDecode() {
        let bundle = Bundle(for: type(of: self))
        guard let path = bundle.url(forResource: "WeatherRequestMocked", withExtension: "json") else {
            XCTFail()
            return
        }

        do {
            let data = try Data(contentsOf: path)
            let weatherDatas = try DecodeRequestData.weatherDatas(data)

            DataSaver.save(data: weatherDatas)

            if let retrievedData = DataSaver.retrieve() {
                XCTAssertEqual(weatherDatas, retrievedData)
            } else {
                XCTFail("Can't retrieve data")
            }

        } catch {
            XCTFail("Can't parse weatherDatas with Jsondecoder, \(error)")
        }
    }

}
