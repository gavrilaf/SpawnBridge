//
//  RegisterDTO.swift
//  SpawnBridge
//
//  Created by Eugen Fedchenko on 10/28/17.
//

import Foundation

public struct RegisterDTO : Codable {
    public let userRegistered: Bool
    
    enum CodingKeys: String, CodingKey {
        case userRegistered = "user_registered"
    }
}
