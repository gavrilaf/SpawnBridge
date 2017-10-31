//
//  TypesTests.swift
//  SpawnBridge_Tests
//
//  Created by Eugen Fedchenko on 10/30/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
import SpawnBridge

class TypesTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testHMAC() {
        let key  = "client_test_key"
        let strs = ["12345", "This is a very long key", "", "client_test", "client_ios", "client_testd1test-user"]
        
        strs.forEach {
            let hmac = $0.hmacSHA512(usingKey: key)
            XCTAssertNotNil(hmac)
            print("Signature for \($0) is \(hmac!.hexEncoded())")
        }
        
    }
    
    func testHexConversions() {
        let source = "This is a test string"
        
        let hexStr = source.convert2Hex()!
        let dataFromHex = Data(bytes: hexStr.parseHex())
        
        let dest = String(bytes: dataFromHex, encoding: .utf8)
        
        XCTAssertEqual(source, dest)
    }
    
}
