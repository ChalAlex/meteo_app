//
//  DetailViewController.swift
//  meteo_app
//
//  Created by Alexandre Jegouic on 10/12/2019.
//  Copyright © 2019 Alexandre Jegouic. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    private var interactor: DetailInteractor = DefaultDetailInteractor()
    fileprivate var model: DetailViewModel = DetailViewModel.initialized

    @IBOutlet private var temperature1: DataView!
    @IBOutlet private var temperature2: DataView!
    @IBOutlet private var humidite: DataView!
    @IBOutlet private var pression: DataView!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor.start(delegate: self)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        interactor.stop()
    }

    public func updateView() {
        self.title = model.title
        self.temperature1.set(model.temperature1)
        self.temperature2.set(model.temperature2)
        self.humidite.set(model.humidite)
        self.pression.set(model.pression)
    }

    public func setWeatherDataId(_ dataId: String) {
        interactor.setWeatherDataId(dataId)
    }
}

extension DetailViewController: DetailDelegate {
    func update(_ model: DetailViewModel) {
        self.model = model
        updateView()
    }
}
