//
//  DefaultInteractor.swift
//  meteo_app
//
//  Created by Alexandre Jegouic on 10/12/2019.
//  Copyright © 2019 Alexandre Jegouic. All rights reserved.
//

import Foundation

private let accessDeniedIdentifier = "AccessDeniedSegue"
private let askAccesIdentifier = "AskAccessSegue"
private let detailIdentifier = "ShowDetailsSegue"

public class DefaultMainInteractor: MainInteractor {
    private var delegate: MainDelegate?

    public init() {}

    public func start(delegate: MainDelegate) {
        self.delegate = delegate
        switch LocalisationState.get() {
        case .ask:
            self.delegate?.launchSegue(askAccesIdentifier)
        case .denied:
            self.delegate?.launchSegue(accessDeniedIdentifier)
        case .access:
            break
        }
    }

    public func stop() {
        delegate = nil
    }

    public func rowSelected(at index: Int) {
        delegate?.launchSegue(detailIdentifier)
    }
}
