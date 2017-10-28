//
//  SpawnAPIDelegate.swift
//  SpawnBridge_Tests
//
//  Created by Eugen Fedchenko on 10/28/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import SpawnBridge

struct SpawnApiDelegate : SpawnRestApiDelegate {
    
    let endpoint: String
    
    var authToken: AuthTokenEntry? {
        get { return _token }
        set { _token = newValue }
    }
    
    init(endpoint: String) {
        self.endpoint = endpoint
    }
    
    func didLogin() {}
    func didLogout() {}
    
    var _token: AuthTokenEntry?
}
