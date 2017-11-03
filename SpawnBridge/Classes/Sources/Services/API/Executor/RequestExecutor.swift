//
//  RequestExecutor.swift
//  SpawnBridge
//
//  Created by Eugen Fedchenko on 10/28/17.

import Foundation
import PromiseKit
import Alamofire


///////////////////////////////////////////////////////////////////////////////////////////////////////////////

class RequestExecutor {
    
    typealias RequestCompletion = (Any?, Error?)
    
    let delegate: SpawnRestApiDelegate
    
    let queue: DispatchQueue
    
    // MARK:
    static let validHttpCodes = [200, 400, 500, 503]
    
    
    
    let authSession: SessionManager
    //let mainSession: SessionManager

    init(delegate: SpawnRestApiDelegate) {
        self.delegate = delegate
        
        queue = DispatchQueue.global(qos: .utility)
        
        authSession = SessionManager()//SessionManager(configuration: congiguration)
        //mainSession = SessionManager(configuration: congiguration)
        
        /*authSession.adapter = UserAgentAdapter()
        mainSession.retrier = RefreshTokenRequestRetrier(delegate: self)
        
        if let token = delegate.authToken {
            configureMainSession(token: token)
        }*/
    }
    
    // MARK:
    
    func logout() {
       /* mainSession.session.getAllTasks { tasks in
            tasks.forEach { $0.cancel() }
        }
        
        mainSession.adapter = nil */
    }
    
    // MARK: Auth section
   
    func runNoAuth<T: Codable>(request: BaseRequest) -> Promise<T> {
        guard let req = request.request(endpoint: delegate.endpoint) else {
                return Promise(error: SpawnError.invalidRequest(request: request))
        }
        
        Logger.i.info(req.description)
        
        return Promise { fulfill, reject in
            authSession.request(req)
                .responseData(queue: queue) { (response) in
                    switch response.result {
                    case .success(let value):
                        do {
                            let decoder = JSONDecoder()
                            decoder.dateDecodingStrategy = .iso8601
                            
                            let code = response.response?.statusCode ?? 500
                            switch code {
                            case 200:
                                fulfill(try decoder.decode(T.self, from: value))
                            default:
                                do {
                                    let err = try decoder.decode(SpawnErrorDTO.self, from: value)
                                    reject(SpawnError.apiError(code: code, err: err))
                                } catch { // invalid json - return just a code
                                    reject(SpawnError.apiError(code: code, err: nil))
                                }
                            }
                        } catch let err {
                            reject(err)
                        }
                    
                    case .failure(let err):
                        reject(err)
                    }
            }
        }
    }
        
    
        

    
    /**
     * For debug
     */
   // func setInvalidToken() {
   //     mainSession.adapter = AccessTokenAdapter(authToken: "Invalid token")
   // }
    
    /*
    
    func didTokenUpdate(newToken: AuthToken) {
        configureMainSession(token: newToken)
        delegate?.didTokenUpdate(token: newToken)
    }
    
    func configureMainSession(token: AuthToken) {
        authToken = token
        mainSession.adapter = AccessTokenAdapter(authToken: token.headerTokenStr)
    }
    
    // MARK:
    private func process(response: DataResponse<Any>, checkToken: Bool, completion: @escaping (Any?, WirexBaseError?) -> Void) {
        response.debugLog(loggingEnabled: responseLoggingEnabled)
        let statusCode = response.response?.statusCode ?? 500
        if statusCode == 200 {
            clearMaintenance(sendNotification: true)
            if checkToken {
                if authToken != nil {
                    completion(response.result.value, nil)
                } else {
                    completion(nil, WirexError.notAuthorized) // User was logged out
                }
            } else {
                completion(response.result.value, nil)
            }
        } else {
            process(error: WirexAPIError(code: statusCode, json: response.result.value), completion: completion)
        }
    }
    
    private func process(error: WirexAPIError, completion: @escaping (Any?, WirexBaseError?) -> Void) {
        if error.kind == .maintenance {
            switchToMaintenance(sendNotification: true)
        } else {
            clearMaintenance(sendNotification: true)
            if error.kind == .forceUpdate {
                switchToForceUpdate(sendNotification: true)
            }
        }
        completion(nil, error)
    }
    
    // MARK:
    
    fileprivate let clientId: String // TODO: Refactor in Swift 4
    fileprivate let clientSecret: String
    
    fileprivate let device: DeviceInfoService
    
    fileprivate let builder: RequestBuilder
    
    fileprivate let congiguration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        
        return config
    }()
    
    fileprivate let queue: DispatchQueue
    
    fileprivate var deviceId: String = ""
    fileprivate var authToken: AuthToken?
    
    fileprivate let responseLoggingEnabled: Bool
    fileprivate let requestLoggingEnabled: Bool
    
    private var _isMaintenanceMode = false
    private var _isForceUpdateNeeded = false
    
    private var serviceStateGuard = NSLock()
 
 */
}


// MARK:
/*
extension RequestExecutor : RefreshTokenRequestRetrierDelegate {
    func refreshToken(completion: @escaping (Bool) -> Void) {
        Logger.i.debug("RequestExecutor.refreshToken, deviceId = \(device.installationId)")
        
        guard let authToken = authToken else {
            Logger.i.error("RequestExecutor.refreshToken, can't refresh nil token")
            completion(false)
            didUserSignOut()
            return
        }
        
        if delegate?.shouldUserRelogin() != true {
            Logger.i.debug("RequestExecutor.refreshToken, shouldUserRelogin == false")
            completion(false)
            didUserSignOut()
            return
        }
        
        let request = builder.refreshTokenRequest(token: authToken,
                                                  clientId: clientId,
                                                  clientSecret: clientSecret,
                                                  deviceId: device.installationId,
                                                  deviceInfo: device.deviceDescription)
        
        if let request = request {
            authSession.request(request)
                .debugLog(loggingEnabled: requestLoggingEnabled)
                .responseJSON { (response) in
                    response.debugLog(loggingEnabled: self.responseLoggingEnabled)
                    
                    var successed = false
                    switch response.result {
                    case .success(let json):
                        if let newToken = Mapper<AuthToken>(context: nil).map(JSONObject: json), newToken.isValid {
                            self.didTokenUpdate(newToken: newToken)
                            Logger.i.info("RequestExecutor.refreshToken, ok")
                            completion(true)
                            successed = true
                        }
                        break
                    default:
                        break
                    }

                    if !successed {
                        Logger.i.error("RequestExecutor.refreshToken, refresh error")
                        completion(false)
                        self.didUserSignOut()
                    }
            }
        } else {
            Logger.i.error("RequestExecutor.refreshToken, can't create refreshToken request")
            completion(false)
            didUserSignOut()
        }
    }
 
 }*/
