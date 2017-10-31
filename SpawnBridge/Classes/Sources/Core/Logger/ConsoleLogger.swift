//
//  ConsoleLogger.swift
//  SpawnBridge
//
//  Created by Eugen Fedchenko on 10/28/17.
//

import Foundation

public struct ConsoleLogger: LoggerProtocol {
    
    public func debug(_ msg: String) {
        print("[DEBUG] \(msg)")
    }
    
    public func info(_ msg: String) {
        print("[INFO] \(msg)")
    }
    
    public func error(msg: String) {
        print("[ERROR] \(msg)")
    }
    
    public func error(err: Error) {
        print("[ERROR] \(err)")
    }
}
