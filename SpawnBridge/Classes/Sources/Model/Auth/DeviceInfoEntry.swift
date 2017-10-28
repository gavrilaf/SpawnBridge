//
//  DeviceInfoEntry.swift
//  SpawnBridge
//
//  Created by Eugen Fedchenko on 10/28/17.
//

import Foundation

public struct DeviceInfoEntry {
    public let deviceId: String
    public let description: String
    
    public init(id: String, desc: String) {
        deviceId = id
        description = desc
    }
}
