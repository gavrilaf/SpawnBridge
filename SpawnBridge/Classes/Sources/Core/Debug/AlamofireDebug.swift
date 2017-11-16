//
//  AlamofireDebug.swift
//  SpawnBridge
//
//  Created by Eugen Fedchenko on 11/16/17.
//

import Foundation
import Alamofire

extension Request {
    func debugLog() -> Self {
        Logger.i.debug("** Request **")
        if let httpBodyData = self.request?.httpBody, let httpBody = String(data: httpBodyData, encoding: .utf8) {
            var escapedBody = httpBody.replacingOccurrences(of: "\\\"", with: "\\\\\"")
            escapedBody = escapedBody.replacingOccurrences(of: "\"", with: "\\\"")
            Logger.i.debug(escapedBody)
        }
        Logger.i.debug(self.description)
        //Logger.i.debug(self.debugDescription)
        Logger.i.debug("**********************************************")
        
        return self
    }
}

extension DataResponse {
    func debugLog() {
        Logger.i.debug("** Response **")
        Logger.i.debug("Request: \(String(describing: self.request?.url))")
        Logger.i.debug("Status code: \(String(describing: self.response?.statusCode))")
        Logger.i.debug((String(describing: self.result.debugDescription)))
        Logger.i.debug("**********************************************")
    }
}
