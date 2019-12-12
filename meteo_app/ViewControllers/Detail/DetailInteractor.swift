//
//  DetailInteractor.swift
//  meteo_app
//
//  Created by Alexandre Jegouic on 10/12/2019.
//  Copyright © 2019 Alexandre Jegouic. All rights reserved.
//

import Foundation

public struct DetailViewModel: Equatable {
    public let title: String
    public let temperature1: DataView.Model
    public let temperature2: DataView.Model
    public let humidite: DataView.Model
    public let pression: DataView.Model

    static let initialized = DetailViewModel(
        title: "Detail",
        temperature1: DataView.Model(title: "2m", data: ""),
        temperature2: DataView.Model(title: "sol", data: ""),
        humidite: DataView.Model(title: "2m", data: ""),
        pression: DataView.Model(title: "Sea level", data: "")
    )
}

public protocol DetailDelegate {
    func update(_ model: DetailViewModel)
}

public protocol DetailInteractor {
    func setWeatherDataId(_ dataId: String)
    func start(delegate: DetailDelegate)
    func stop()
}
