//
//  MockedRequestManager.swift
//  meteo_appTests
//
//  Created by Alexandre Jegouic on 11/12/2019.
//  Copyright © 2019 Alexandre Jegouic. All rights reserved.
//

import Foundation
@testable import meteo_app

public enum MockedRequestManagerstate {
    case success
    case badUrl
    case error
}

public class MockedRequestManager: RequestManager {
    private let state: MockedRequestManagerstate

    public init(state: MockedRequestManagerstate) {
        self.state = state
    }
    
    public func getWeatherData(completion: @escaping (Result<Data, Error>) -> Void) {
        switch state {
        case .success:
            let bundle = Bundle(for: type(of: self))
            let path = bundle.url(forResource: "WeatherRequestMocked", withExtension: "json")
            let data = try! Data(contentsOf: path!)
            completion(.success(data))
        case .badUrl:
            completion(.failure(URLError(.badURL)))
        case .error:
            completion(.failure(URLError(.badServerResponse)))
        }
    }
}
