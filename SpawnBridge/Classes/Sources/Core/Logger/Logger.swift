//
//  Logger.swift
//  SpawnBridge
//
//  Created by Eugen Fedchenko on 10/28/17.
//

import Foundation
import SwiftyBeaver

public struct Logger {
    
    public static var i = { () -> SwiftyBeaver.Type in
        let log = SwiftyBeaver.self
        
        let console = ConsoleDestination()
        log.addDestination(console)
        
        return log
    }()
}

