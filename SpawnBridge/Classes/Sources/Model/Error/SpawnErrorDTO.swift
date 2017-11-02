//
//  SpawnErrorDTO.swift
//  SpawnBridge
//
//  Created by Eugen Fedchenko on 10/28/17.
//

import Foundation

public struct SpawnErrorDTO: Codable {
    public struct ErrorDTO: Codable {
        public let scope: String
        public let reason: String?
        public let message: String?
    }

    public let error: ErrorDTO
}

extension SpawnErrorDTO: CustomStringConvertible {
    public var description: String {
        return "(Scope: \(error.scope), Reason: \(error.reason ?? "(empty)"), Message: \(error.message ?? "(empty)")"
    }
}

