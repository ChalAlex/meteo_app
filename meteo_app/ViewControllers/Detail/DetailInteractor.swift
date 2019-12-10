//
//  DetailInteractor.swift
//  meteo_app
//
//  Created by Alexandre Jegouic on 10/12/2019.
//  Copyright © 2019 Alexandre Jegouic. All rights reserved.
//

import Foundation

public struct DetailViewModel {
    public let title: String
    public let temperature: String
    static let initialized = DetailViewModel(title: "Detail", temperature: "")
}

public protocol DetailDelegate {
    func update(_ model: DetailViewModel)
}

public protocol DetailInteractor {
    func start(delegate: DetailDelegate)
    func stop()
}
