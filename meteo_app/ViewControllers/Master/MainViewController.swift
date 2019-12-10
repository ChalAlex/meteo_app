//
//  MainViewController.swift
//  meteo_app
//
//  Created by Alexandre Jegouic on 10/12/2019.
//  Copyright © 2019 Alexandre Jegouic. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    private var interactor: MainInteractor = DefaultMainInteractor()
    fileprivate var model: MainViewModel = MainViewModel.initialized

    @IBOutlet fileprivate var tableView: UITableView!

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
        tableView.reloadData()
    }
}

extension MainViewController: MainDelegate {
    func update(_ model: MainViewModel) {
        self.model = model
        updateView()
    }

    func launchSegue(_ identifier: String) {
        self.performSegue(withIdentifier: identifier, sender: self)
    }
}

extension MainViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = model.cells[indexPath.row].title
        cell.detailTextLabel?.text = model.cells[indexPath.row].subtitle
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor.rowSelected(at: indexPath.row)
    }
}
