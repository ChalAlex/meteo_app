//
//  ForbiddenAccessViewController.swift
//  meteo_app
//
//  Created by Alexandre Jegouic on 10/12/2019.
//  Copyright © 2019 Alexandre Jegouic. All rights reserved.
//

import UIKit

class ForbiddenAccessViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(
            self, selector:
            #selector(appMovedToForeground),
            name: UIApplication.willEnterForegroundNotification,
            object: nil)
    }

    @IBAction func openSettings(_ sender: Any) {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
            NSLog("Can't generate the Url Settings")
            return
        }
        UIApplication.shared.open(settingsUrl)
    }

    @objc func appMovedToForeground() {
        self.dismiss(animated: true, completion: nil)
    }
}
