//
//  SwawnRestApi.swift
//  SpawnBridge
//
//  Created by Eugen Fedchenko on 10/28/17.
//

import Foundation

public protocol SpawnRestApiDelegate {
    // Spawn endpoint
    var endpoint: String { get }
    
    //
    var authToken: AuthTokenEntry? { get set }
    
    //
    func didLogin()
    func didLogout()
}

public protocol SpawndRestApi {
    
    init(delegate: SpawnRestApiDelegate)
    
    var auth: AuthApiProtocol { get }
}
