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
                                      device: DeviceInfoEntry(id: "d1", desc: "d1 device name", locale: "en", lang: "en"),
                                      username: name,
                                      password: "test-password")
        
        api.auth.register(request: request).then { (dto) -> Void in
            
            XCTAssertFalse(dto.authToken.isEmpty)
            XCTAssertFalse(dto.refreshToken.isEmpty)
            
            XCTAssertTrue(dto.permissions.isDeviceConfirmed) // Device is confirmed after registration
            
            XCTAssertFalse(dto.permissions.is2FARequired)
            XCTAssertFalse(dto.permissions.isEmailConfirmed)
            XCTAssertFalse(dto.permissions.isLocked)
            
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
            XCTAssertFalse(dto.authToken.isEmpty)
            XCTAssertFalse(dto.refreshToken.isEmpty)
            
            XCTAssertTrue(dto.permissions.isDeviceConfirmed)
            
            XCTAssertFalse(dto.permissions.is2FARequired)
            XCTAssertFalse(dto.permissions.isEmailConfirmed)
            XCTAssertFalse(dto.permissions.isLocked)
            
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
                                   device: DeviceInfoEntry(id: "unknown", desc: "unknown", locale: "", lang: ""),
                                   username: Environment.existingUser.username,
                                   password: Environment.existingUser.psw)
        
        api.auth.login(request: request).then { (dto) -> Void in
            // Login successed but device is not confirmed
            
            XCTAssertFalse(dto.authToken.isEmpty)
            XCTAssertFalse(dto.refreshToken.isEmpty)
            
            XCTAssertFalse(dto.permissions.isDeviceConfirmed)
            
            XCTAssertFalse(dto.permissions.is2FARequired)
            XCTAssertFalse(dto.permissions.isEmailConfirmed)
            XCTAssertFalse(dto.permissions.isLocked)
            
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
    
    func testRefreshToken() {
        let exp = expectation(description: "")
        let request = LoginRequest(client: Environment.client,
                                   device: Environment.existingUser.device,
                                   username: Environment.existingUser.username,
                                   password: Environment.existingUser.psw)
        
        api.auth.login(request: request).then { (dto) -> Promise<AuthTokenDTO> in
            let refreshReq = RefreshTokenRequest(auth: dto.authToken, refresh: dto.refreshToken)
            return self.api.auth.refreshToken(request: refreshReq)
        }.then { (dto) -> Void in
            XCTAssertGreaterThan(dto.authToken.count, 0)
            XCTAssertEqual(dto.refreshToken.count, 0)
            
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
    
    func testFullProcess() {
        let exp = expectation(description: "")
        
        let username = createUserName()
        let device = DeviceInfoEntry(id: "d1", desc: "d1 device name", locale: "en", lang: "en")
        let password = "test-password"
        
        let regRequest = RegisterRequest(client: Environment.client, device: device, username: username, password: password)
        
        api.auth.register(request: regRequest).then { (_) -> Promise<AuthTokenDTO> in
            let loginRequest = LoginRequest(client: Environment.client, device: device, username: username, password: password)
            return self.api.auth.login(request: loginRequest)
        }.then { (dto) -> Promise<AuthTokenDTO> in
            XCTAssertFalse(dto.authToken.isEmpty)
            XCTAssertFalse(dto.refreshToken.isEmpty)
            
            XCTAssertTrue(dto.permissions.isDeviceConfirmed)
            
            let refreshRequest = RefreshTokenRequest(auth: dto.authToken, refresh: dto.refreshToken)
            return self.api.auth.refreshToken(request: refreshRequest)
        }.then { (dto) -> Void in
            XCTAssertFalse(dto.authToken.isEmpty)
            XCTAssertTrue(dto.refreshToken.isEmpty)
            
            XCTAssertTrue(dto.permissions.isDeviceConfirmed)
            
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
    
}
