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
        switch self {
        case .invalidJson:
            return "Invalid json"
        case .internalError(let msg):
            return "Internal error: \(msg)"
        case .invalidRequest(let request):
            return "Invalid request: \(request)"
        case .sysError(let err):
            return "System error: \(err)"
        case .apiError(let code, let json):
            if let json = json {
                return "Api error, code = \(code): \(json)"
            } else {
                return "Api error, code = \(code)"
            }
        }
    }
}


