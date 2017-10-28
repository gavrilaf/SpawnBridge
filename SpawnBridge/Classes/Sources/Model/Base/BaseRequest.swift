//
//  BaseRequest.swift
//  SpawnBridge
//
//  Created by Eugen Fedchenko on 10/28/17.
//

import Foundation
import Alamofire

public protocol BaseRequest {
    func request(endpoint: String) -> URLRequest?
}

extension BaseRequest {
    func buildUrl(endpoint: String, path: String) -> URLConvertible {
        return endpoint + "/" + path
    }
}
