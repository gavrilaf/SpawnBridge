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
    
    func createUserName() -> String {
        let s = UUID().uuidString
        return "\(s)@spawn.com"
    }
    
    func testRegister() {
        let exp = expectation(description: "")
        
        let name = createUserName()
        let request = RegisterRequest(client: Environment.client,
                                      device: DeviceInfoEntry(id: "d1", desc: "d1 device name"),
                                      username: name,
                                      password: "test-password")
        
        api.auth.register(request: request).then { (dto) -> Void in
            exp.fulfill()
        }.catch { (err) in
            XCTFail("\(err)")
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 30) { (err) in
            if let err = err {
                XCTFail(err.localizedDescription)
            }
        }
    }
    
    func testRegisterAlreadyExists() {
        let exp = expectation(description: "")
        
        let exists = RegisterRequest(client: Environment.client,
                                     device: Environment.existingUser.device,
                                     username: Environment.existingUser.username,
                                     password: Environment.existingUser.psw)
        
        api.auth.register(request: exists).then { (_) -> Void in
            XCTFail("Must be error")
        }.catch { (err) in
            let err2 = err as? SpawnError
            XCTAssertNotNil(err2)
            
            switch err2! {
            case .apiError(let code, let err3):
                XCTAssertEqual(code, 500)
                XCTAssertNotNil(err3)
                XCTAssertEqual(err3?.error.scope, "auth")
                XCTAssertEqual(err3?.error.reason, "user-already-exist")
            default:
                XCTFail("Must be api error")
            }
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 30) { (err) in
            if let err = err {
                XCTFail(err.localizedDescription)
            }
        }
    }
    
    func testLogin() {
        let exp = expectation(description: "")
        let request = LoginRequest(client: Environment.client,
                                   device: Environment.existingUser.device,
                                   username: Environment.existingUser.username,
                                   password: Environment.existingUser.psw)
        
        api.auth.login(request: request).then { (dto) -> Void in
            exp.fulfill()
        }.catch { (err) in
            XCTFail("\(err)")
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 30) { (err) in
            if let err = err {
                XCTFail(err.localizedDescription)
            }
        }
    }
    
    func testLoginInvalidPassword() {
        let exp = expectation(description: "")
        let request = LoginRequest(client: Environment.client,
                                   device: Environment.existingUser.device,
                                   username: Environment.existingUser.username,
                                   password: "invalid password")
        
        api.auth.login(request: request).then { (_) -> Void in
            XCTFail("Must be error")
        }.catch { (err) in
            let err2 = err as? SpawnError
            XCTAssertNotNil(err2)
                
            switch err2! {
            case .apiError(let code, let err3):
                XCTAssertEqual(code, 401)
                XCTAssertNotNil(err3)
                XCTAssertEqual(err3?.error.scope, "auth")
                XCTAssertEqual(err3?.error.reason, "user-unknown")
            default:
                XCTFail("Must be api error")
            }
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 30) { (err) in
            if let err = err {
                XCTFail(err.localizedDescription)
            }
        }
    }
    
    func testLoginUnknowClient() {
        let exp = expectation(description: "")
        let request = LoginRequest(client: SpawnClientEntry(id: "invalid", secret: "11111"),
                                   device: Environment.existingUser.device,
                                   username: Environment.existingUser.username,
                                   password: Environment.existingUser.psw)
        
        api.auth.login(request: request).then { (_) -> Void in
            XCTFail("Must be error")
            }.catch { (err) in
                let err2 = err as? SpawnError
                XCTAssertNotNil(err2)
                
                switch err2! {
                case .apiError(let code, let err3):
                    XCTAssertEqual(code, 401)
                    XCTAssertNotNil(err3)
                    XCTAssertEqual(err3?.error.scope, "auth")
                    XCTAssertEqual(err3?.error.reason, "client-unknown")
                default:
                    XCTFail("Must be api error")
                }
                exp.fulfill()
        }
        
        waitForExpectations(timeout: 30) { (err) in
            if let err = err {
                XCTFail(err.localizedDescription)
            }
        }
    }
    
    func testLoginUnknowDevice() {
        let exp = expectation(description: "")
        let request = LoginRequest(client: Environment.client,
                                   device: DeviceInfoEntry(id: "unknown", desc: ""),
                                   username: Environment.existingUser.username,
                                   password: Environment.existingUser.psw)
        
        api.auth.login(request: request).then { (_) -> Void in
            XCTFail("Must be error")
            }.catch { (err) in
                let err2 = err as? SpawnError
                XCTAssertNotNil(err2)
                
                switch err2! {
                case .apiError(let code, let err3):
                    XCTAssertEqual(code, 401)
                    XCTAssertNotNil(err3)
                    XCTAssertEqual(err3?.error.scope, "auth")
                    XCTAssertEqual(err3?.error.reason, "device-unknown")
                default:
                    XCTFail("Must be api error")
                }
                exp.fulfill()
        }
        
        waitForExpectations(timeout: 30) { (err) in
            if let err = err {
                XCTFail(err.localizedDescription)
            }
        }
    }
}
