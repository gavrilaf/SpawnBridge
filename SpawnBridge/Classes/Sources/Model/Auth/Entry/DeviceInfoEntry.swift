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
    public let locale: String
    public let lang: String
    
    public init(id: String, desc: String, locale: String, lang: String) {
        self.deviceId       = id
        self.description    = desc
        self.locale         = locale
        self.lang           = lang
    }
}
