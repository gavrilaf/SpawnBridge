//
//  PermissionsDTO.swift
//  SpawnBridge
//
//  Created by Eugen Fedchenko on 11/15/17.
//

import Foundation

public struct PermissionsDTO : Codable {
    
    public let isDeviceConfirmed: Bool
    public let isEmailConfirmed: Bool
    public let is2FARequired: Bool
    public let isLocked: Bool
    public let scopes: Int64
    
    enum CodingKeys: String, CodingKey {
        case isDeviceConfirmed  = "is_device_confirmed"
        case isEmailConfirmed   = "is_email_confirmed"
        case is2FARequired      = "is_2fa_reqired"
        case isLocked           = "is_locked"
        case scopes             = "scopes"
    }
}
