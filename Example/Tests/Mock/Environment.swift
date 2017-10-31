//
//  Environment.swift
//  SpawnBridge_Tests
//
//  Created by Eugen Fedchenko on 10/28/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import SpawnBridge

struct Environment {
    static let endpoint = "http://localhost:8080"
    
    static let client = SpawnClientEntry(id: "client_test",
                                         secret: "client_test_key")
    
     
    
}
