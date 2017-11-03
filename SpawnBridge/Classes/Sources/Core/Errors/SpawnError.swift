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
    case apiError(code: Int, err: SpawnErrorDTO?)
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
        case .apiError(let code, let err):
            if let err = err {
                return "Api error, code = \(code): \(err)"
            } else {
                return "Api error, code = \(code)"
            }
        }
    }
}


