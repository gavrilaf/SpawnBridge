//
//  Data.swift
//  SpawnBridge
//
//  Created by Eugen Fedchenko on 10/29/17.
//

import Foundation

extension Data {
    
    public static func fromHex(string: String) -> Data {
        return Data(bytes: string.parseHex())
    }
    
    public func hexEncoded() -> String {
        return map { String(format: "%02hhx", $0) }.joined()
    }
    
    public func toBytes() -> [UInt8] {
        return self.withUnsafeBytes {
            [UInt8](UnsafeBufferPointer(start: $0, count: self.count/MemoryLayout<UInt8>.stride))
        }
    }
    
    public static func xor(data: Data, with key: Data) -> Data {
        var xorData = data
        
        xorData.withUnsafeMutableBytes { (start: UnsafeMutablePointer<UInt8>) -> Void in
            key.withUnsafeBytes { (keyStart: UnsafePointer<UInt8>) -> Void in
                let b = UnsafeMutableBufferPointer<UInt8>(start: start, count: xorData.count)
                let k = UnsafeBufferPointer<UInt8>(start: keyStart, count: data.count)
                
                let length = key.count
                for i in 0..<xorData.count {
                    b[i] ^= k[i % length]
                }
            }
        }
        
        return xorData
    }
}
