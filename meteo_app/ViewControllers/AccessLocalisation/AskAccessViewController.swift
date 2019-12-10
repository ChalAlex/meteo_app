//
//  AskAccessViewController.swift
//  meteo_app
//
//  Created by Alexandre Jegouic on 10/12/2019.
//  Copyright © 2019 Alexandre Jegouic. All rights reserved.
//

import UIKit

class AskAccessViewController: UIViewController {
    private let locationManager = LocalisationManager()

    @IBAction func askAccess(_ sender: Any) {
        locationManager.askAccess { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
    }
}
