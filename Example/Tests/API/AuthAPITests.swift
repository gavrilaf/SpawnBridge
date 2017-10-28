//
//  AuthAPITests.swift
//  SpawnBridge_Tests
//
//  Created by Eugen Fedchenko on 10/28/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
import PromiseKit
import SpawnBridge

class AuthAPITests: XCTestCase {
    
    var apiDelegate: SpawnApiDelegate!
    var api: SpawndRestApi!
    
    override func setUp() {
        super.setUp()
        
        apiDelegate = SpawnApiDelegate(endpoint: Environment.endpoint)
        api = SpawnRestApiAssembly(delegate: apiDelegate)
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRegister() {
        let exp = expectation(description: "")
        
        let request = RegisterRequest(client: Environment.client,
                                      device: DeviceInfoEntry(id: "d1", desc: "d1 device name"),
                                      username: "test-user",
                                      password: "test-password")
        
        api.auth.register(request: request).then { (dto) -> Void in
            exp.fulfill()
        }.catch { (err) in
            XCTFail(err.localizedDescription)
            exp.fulfill()
        }
        
        
        waitForExpectations(timeout: 30) { (err) in
            if let err = err {
                XCTFail(err.localizedDescription)
            }
        }
    }
    
    
    
}
