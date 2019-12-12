//
//  RequestManager.swift
//  meteo_app
//
//  Created by Alexandre Jegouic on 11/12/2019.
//  Copyright © 2019 Alexandre Jegouic. All rights reserved.
//

import Foundation

public protocol RequestManager {
    func getWeatherData(completion: @escaping (Result<Data, Error>) -> Void)
}

public class ImpRequestManager: RequestManager {
    private let locationManager = LocalisationManager()
    private let session = URLSession.shared

    public func getWeatherData(completion: @escaping (Result<Data, Error>) -> Void) {
         let locationSucceed = locationManager.localisation() { [weak self] longitude, latitude in
            guard let url = URL(string: ImpRequestManager.getUrlString(lattitude: latitude, longitude: longitude)) else {
                completion(.failure(URLError(.badURL)))
                return
            }
            let task = self?.session.dataTask(with: URLRequest(url: url)) { data, _, error in
                if let data = data {
                    completion(.success(data))
                } else if let  error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(URLError(.badServerResponse)))
                }
            }
            task?.resume()
        }

        if !locationSucceed {
            completion(.failure(URLError(.badURL)))
        }
    }

    private static func getUrlString(lattitude: Double, longitude: Double) -> String {
        return "http://www.infoclimat.fr/public-api/gfs/json?_ll=\(lattitude),\(longitude)&_auth=VE4HEA5wU3FWewA3VCIGLwNrUmdbLVVyUS0AYw9qB3pROl8%2BUTFdO1U7VClSfVVjVHkFZggzUGALYFYuCngFZFQ%2BB2sOZVM0VjkAZVR7Bi0DLVIzW3tVclE6AGUPfAdlUTBfP1EsXT5VO1Q3UnxVYlRkBXoIKFBpC21WNgphBWZUNwdmDmlTNFY9AH1UewY3A2RSZ1syVThRZABjDzcHYFFnXzpRZF09VThUKFJqVWhUZQVnCDFQbwtpVjEKeAV5VE4HEA5wU3FWewA3VCIGLwNlUmxbMA%3D%3D&_c=9fd53217366b8ea2e0ee3fb144d54aeb"
    }
}
