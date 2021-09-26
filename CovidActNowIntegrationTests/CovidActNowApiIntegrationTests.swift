//
//  CovidActNowApiIntegrationTests.swift
//  CovidActNowIntegrationTests
//
//  Created by Michael Baldwin on 9/22/21.
//

import XCTest
@testable import CovidActNow

class CovidActNowApiIntegrationTests: XCTestCase {

    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        
    }

    func testGetStateDataForOregon() async throws {
        // Given
        let covidActNowService = CovidActNowService()
        var expectedResult: StateData?
        
        // When
        let result = await covidActNowService.getDataFor(state: .Oregon)
        
        switch result {
        case let .success(resultData):
            expectedResult = resultData
        case let .failure(error):
            XCTFail("Mock session failed with error: \(error)")
        }
        
        let stateData = try XCTUnwrap(expectedResult)
        
        // Then
        XCTAssertEqual(stateData.abbreviation, "OR")
        XCTAssertEqual(stateData.fips.stringValue, "41")
        XCTAssertEqual(stateData.fips.intValue, 41)
        XCTAssertTrue(stateData.population > 1_000_000)
    }
    
}
