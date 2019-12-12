//
//  ModelManagerTests.swift
//  meteo_appTests
//
//  Created by Alexandre Jegouic on 12/12/2019.
//  Copyright © 2019 Alexandre Jegouic. All rights reserved.
//

import XCTest
@testable import meteo_app

class ModelManagerTests: XCTestCase {

    func testRequestFailed() {
        let expectation = self.expectation(description: "waitErrorCompletion")
        let modelManager = ImpModelManager.createMockedRequest(state: .error)

        modelManager.refreshData { error in
            XCTAssertNotNil(error)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 3, handler: nil)
    }

    func testRequestSucceed() {
        let expectation = self.expectation(description: "waitSuccessCompletion")
        let modelManager = ImpModelManager.createMockedRequest(state: .success)

        modelManager.refreshData { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 3, handler: nil)
    }

    func testListenersCalled() {
        let expectation = self.expectation(description: "waitSuccessCompletion")
        let expectation2 = self.expectation(description: "waitListenerDatasCalled")
        let expectation3 = self.expectation(description: "waitListenerDataCalled")

        let modelManager = ImpModelManager.createMockedRequest(state: .success)
        let mockedListenerDatas = MockedListenerWeatherDatas {
            expectation2.fulfill()
        }
        let mockedListenerData = MockedListenerWeatherData {
            expectation3.fulfill()
        }

        modelManager.add(mockedListenerDatas)
        modelManager.add(mockedListenerData)

        modelManager.refreshData { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 3, handler: nil)
    }

}
