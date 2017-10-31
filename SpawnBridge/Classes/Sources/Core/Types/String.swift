//
//  String.swift
//  SpawnBridge
//
//  Created by Eugen Fedchenko on 10/29/17.
//

import Foundation

extension String {
    public func parseHex() -> [UInt8] {
        guard count > 0 && count % 2 == 0 else { return [] }
        
        var data = [UInt8](repeating: 0, count: self.characters.count/2)
        var byteLiteral = ""
        
        for (index, character) in self.characters.enumerated() {
            if index % 2 == 0 {
                byteLiteral = String(character)
            } else {
                byteLiteral.append(character)
                guard let byte = UInt8(byteLiteral, radix: 16) else { return [] }
                data[index / 2] = byte
            }
        }
        return data
    }
    
    public func convert2Hex() -> String? {
        return self.data(using: .utf8)?.hexEncoded()
    }
    
    /// Calculate HMAC SHA512 from string (acsii) and key (ascii)
    public func hmacSHA512(usingKey key: String) -> Data? {
        return Cryptx.hmacSHA512(self, usingKey: key)
    }
}
