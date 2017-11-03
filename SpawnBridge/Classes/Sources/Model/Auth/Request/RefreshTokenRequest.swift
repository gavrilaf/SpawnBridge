//
//  RefreshTokenRequest.swift
//  Alamofire
//
//  Created by Eugen Fedchenko on 11/3/17.
//

import Foundation
import Alamofire

public struct RefreshTokenRequest {
    public let authToken: String
    public let refreshToken: String
    
    public init(auth: String, refresh: String) {
        self.authToken = auth
        self.refreshToken = refresh
    }
}

extension RefreshTokenRequest: BaseRequest {
    public func request(endpoint: String) -> URLRequest? {
        let url = buildUrl(endpoint: endpoint, path: "auth/refresh_token")
        let parameters: Dictionary<String, Any> = [
            "auth_token"    : authToken,
            "refresh_token" : refreshToken
        ]
        
        return try? JSONEncoding.default.encode(URLRequest(url: url, method: .post), with: parameters)
    }
}
