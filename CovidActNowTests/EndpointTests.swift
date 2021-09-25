//
//  EndpointTests.swift
//  CovidActNowTests
//
//  Created by Michael Baldwin on 9/24/21.
//

import XCTest
@testable import CovidActNow

class EndpointTests: XCTestCase {

    func testStatesEndpoint() throws {
        // Given
        let endpoint = StatesEndpoint(for: .Oregon)
        
        // When
        let url = try XCTUnwrap(endpoint.request.url)
        let queryItem = try XCTUnwrap(endpoint.queryItems.first)
        
        // Then
        XCTAssertEqual(endpoint.scheme, "https")
        XCTAssertEqual(endpoint.host, "api.covidactnow.org")
        XCTAssertEqual(endpoint.path, "/v2/state/OR.json")
        
        XCTAssertEqual(queryItem.debugDescription, "apiKey=6cef8ab3821b483a8d0ab990da2b02e3")
        
        XCTAssertEqual(url.absoluteString, "https://api.covidactnow.org/v2/state/OR.json?apiKey=6cef8ab3821b483a8d0ab990da2b02e3")
    }

}
