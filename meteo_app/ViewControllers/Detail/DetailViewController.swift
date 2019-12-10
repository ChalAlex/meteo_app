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

    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        interactor.start(delegate: self)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        interactor.stop()
    }

    public func updateView() {
        self.title = model.title
    }
}

extension DetailViewController: DetailDelegate {
    func update(_ model: DetailViewModel) {
        self.model = model
        updateView()
    }
}
