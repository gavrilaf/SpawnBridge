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
    
    public func register(request: RegisterRequest) -> Promise<RegisterDTO> {
        return executor.runNoAuth(request: request)
    }
}
