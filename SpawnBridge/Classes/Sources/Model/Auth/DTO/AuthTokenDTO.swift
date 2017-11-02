//
//  AuthTokenDTO.swift
//  SpawnBridge
//
//  Created by Eugen Fedchenko on 11/2/17.
//

import Foundation

public struct AuthTokenDTO : Codable {
    public let authToken: String
    public let refreshToken: String
    public let expire: Date
    
    enum CodingKeys: String, CodingKey {
        case authToken = "auth_token"
        case refreshToken = "refresh_token"
        case expire = "expire"
    }
}
