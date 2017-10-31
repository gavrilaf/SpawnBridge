//
//  SpawnError.swift
//  SpawnBridge
//
//  Created by Eugen Fedchenko on 10/28/17.
//

import Foundation

public enum SpawnError: Error {
    case invalidJson
    case internalError(msg: String)
    case invalidRequest(request: BaseRequest)
    case sysError(err: Error)
    case apiError(code: Int, json: SpawnErrorDTO?)
}

extension SpawnError: CustomStringConvertible {
    public var description: String {
        return "error"
    }
}


