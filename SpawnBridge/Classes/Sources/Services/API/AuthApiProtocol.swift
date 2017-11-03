//
//  SpawnAuthApi.swift
//  SpawnBridge
//
//  Created by Eugen Fedchenko on 10/28/17.
//

import Foundation
import PromiseKit

public protocol AuthApiProtocol {
    
    func register(request: RegisterRequest) -> Promise<RegisterDTO>
    
    func login(request: LoginRequest) -> Promise<AuthTokenDTO>
    func refreshToken(request: RefreshTokenRequest) -> Promise<AuthTokenDTO>
    
}
