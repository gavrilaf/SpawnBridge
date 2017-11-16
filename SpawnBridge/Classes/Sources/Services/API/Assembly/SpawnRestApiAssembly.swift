//
//  SpawnRestApiAssembly.swift
//  SpawnBridge
//
//  Created by Eugen Fedchenko on 10/28/17.
//

import Foundation
import PromiseKit

public class SpawnRestApiAssembly: SpawndRestApi {
    
    let delegate: SpawnRestApiDelegate
    let executor: RequestExecutor
    
    public required init(delegate: SpawnRestApiDelegate) {
        self.delegate = delegate
        self.executor = RequestExecutor(delegate: delegate)
    }
    
    public var auth: AuthApiProtocol { return self }
    
}

// MARK:

extension SpawnRestApiAssembly: AuthApiProtocol {
    
    public func register(request: RegisterRequest) -> Promise<AuthTokenDTO> {
        return executor.runNoAuth(request: request)
    }
    
    public func login(request: LoginRequest) -> Promise<AuthTokenDTO> {
        return executor.runNoAuth(request: request)
    }
    
    public func refreshToken(request: RefreshTokenRequest) -> Promise<AuthTokenDTO> {
        return executor.runNoAuth(request: request)
    }
}
