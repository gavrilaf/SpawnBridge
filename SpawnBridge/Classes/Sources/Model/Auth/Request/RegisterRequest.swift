//
//  RegisterParcel.swift
//  SpawnBridge
//
//  Created by Eugen Fedchenko on 10/28/17.
//

import Foundation
import Alamofire

public struct RegisterRequest {
    public let client: SpawnClientEntry
    public let device: DeviceInfoEntry
    
    public let username: String
    public let password: String
    
    public init(client: SpawnClientEntry, device: DeviceInfoEntry, username: String, password: String) {
        self.client = client
        self.device = device
        self.username = username
        self.password = password
    }
    
    public var signature: String {
        return (client.id + device.deviceId + username).hmacSHA512(usingKey: client.secret)?.hexEncoded() ?? ""
    }
}

extension RegisterRequest: BaseRequest {
    public func request(endpoint: String) -> URLRequest? {
        let url = buildUrl(endpoint: endpoint, path: "auth/register")
        let parameters: Dictionary<String, Any> = [
            "client_id"     : client.id,
            "device_id"     : device.deviceId,
            "device_name"   : device.description,
            "username"      : username,
            "password"      : password,
            "locale"        : device.locale,
            "lang"          : device.lang,
            "signature"     : signature
        ]
        
        return try? JSONEncoding.default.encode(URLRequest(url: url, method: .post), with: parameters)
    }
}

