//
//  Logger.swift
//  SpawnBridge
//
//  Created by Eugen Fedchenko on 10/28/17.
//

import Foundation

public struct Logger: LoggerProtocol {
    
    public static let i = Logger()
    
    public var impl: LoggerProtocol = ConsoleLogger()
    
    public func debug(_ msg: String) {
        impl.debug(msg)
    }
    
    public func info(_ msg: String) {
        impl.info(msg)
    }
    
    public func error(msg: String) {
        impl.info(msg)
    }
    
    public func error(err: Error) {
        impl.error(err: err)
    }
}
