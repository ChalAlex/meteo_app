//
//  DataView.swift
//  meteo_app
//
//  Created by Alexandre Jegouic on 12/12/2019.
//  Copyright © 2019 Alexandre Jegouic. All rights reserved.
//

import UIKit

public class DataView: UIView {
    public struct Model: Equatable {
        let title: String
        let data: String

        static let initialized = Model(title: "", data: "")
    }

    @IBOutlet fileprivate var title: UILabel!
    @IBOutlet fileprivate var data: UILabel!

    private var model: DataView.Model? {
        didSet {
            title.text = model?.title
            data.text = model?.data
        }
    }

    public func set(_ model: DataView.Model) {
        self.model = model
    }
}
