//
//  LoggerProtocol.swift
//  SpawnBridge
//
//  Created by Eugen Fedchenko on 10/28/17.
//

import Foundation

public protocol LoggerProtocol {
    func debug(_ msg: String)
    func info(_ msg: String)
    
    func error(msg: String)
    func error(err: Error)
}
