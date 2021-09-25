//
//  FipsTests.swift
//  CovidActNowTests
//
//  Created by Michael Baldwin on 9/23/21.
//

import XCTest
@testable import CovidActNow

class FipsTests: XCTestCase {

    func testInitializeFipsWithString() {
        // Given
        let fips = Fips(with: "123456")
        
        // Then
        XCTAssertEqual(fips.intValue, 123456)
        XCTAssertEqual(fips.stringValue, "123456")
    }
    
    func testInitializeFipsWithStringLiteral() {
        // Given
        let fips: Fips = "123456"
        
        // Then
        XCTAssertEqual(fips.intValue, 123456)
        XCTAssertEqual(fips.stringValue, "123456")
    }
    
    func testInitializeFipsWithInt() {
        // Given
        let fips = Fips(with: 123456)
        
        // Then
        XCTAssertEqual(fips.intValue, 123456)
        XCTAssertEqual(fips.stringValue, "123456")
    }

}
