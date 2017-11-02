//
//  SpawnClientEntry.swift
//  SpawnBridge
//
//  Created by Eugen Fedchenko on 10/28/17.
//

import Foundation

public struct SpawnClientEntry {
    public let id: String
    public let secret: String
    
    public init(id: String, secret: String) {
        self.id = id
        self.secret = secret
    }
}
