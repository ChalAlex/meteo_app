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

    public init() {}

    public func start(delegate: DetailDelegate) {
        self.delegate = delegate
    }

    public func stop() {
        delegate = nil
    }
}
