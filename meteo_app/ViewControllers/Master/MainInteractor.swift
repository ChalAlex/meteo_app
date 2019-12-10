//
//  MainViewControllerInteractor.swift
//  meteo_app
//
//  Created by Alexandre Jegouic on 10/12/2019.
//  Copyright © 2019 Alexandre Jegouic. All rights reserved.
//

import Foundation

public struct MainViewModel {
    public struct CellModel {
        public let title: String
        public let subtitle: String
    }

    public let title: String
    public let cells: [CellModel]
    static let initialized = MainViewModel(title: "", cells: [])
}

public protocol MainDelegate {
    func launchSegue(_ identifier: String)
    func update(_ model: MainViewModel)
}

public protocol MainInteractor {
    func start(delegate: MainDelegate)
    func stop()
    func rowSelected(at index: Int)
}
