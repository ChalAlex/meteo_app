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
    private var model = MainViewModel.initialized

    public init() {}

    public func start(delegate: MainDelegate) {
        self.delegate = delegate
        switch LocalisationState.get() {
        case .ask:
            DispatchQueue.main.async { [weak self] in
                self?.delegate?.launchSegue(askAccesIdentifier, dataId: "")
            }
        case .denied:
            DispatchQueue.main.async { [weak self] in
                self?.delegate?.launchSegue(accessDeniedIdentifier, dataId: "")
            }
        case .access:
            AppDelegate.modelManager.add(self)
            AppDelegate.modelManager.refreshData { error in
                if let error = error {
                    DispatchQueue.main.async { [weak self] in
                        self?.delegate?.showAlert(title: "Error", message: error.localizedDescription)
                    }
                }
            }
        }
    }

    public func stop() {
        delegate = nil
        AppDelegate.modelManager.remove(self)
    }

    public func rowSelected(at index: Int) {
        let dataId = model.cells[index].title
        DispatchQueue.main.async { [weak self] in
            self?.delegate?.launchSegue(detailIdentifier, dataId: dataId)
        }
    }
}

extension DefaultMainInteractor: WeatherDatasListener {
    public var id: String { return "DefaultMainInteractor" }

    public func updatedWeatherDatas(weatherDatas: [String : WeatherData]) {
        let newModel = MainViewModel(
            title: "Main",
            cells: weatherDatas.keys.map { MainViewModel.CellModel(title: $0, subtitle: "detail") }
        )
        if newModel != model {
            model = newModel
            DispatchQueue.main.async { [weak self] in
                self?.delegate?.update(newModel)
            }
        }
    }
}
