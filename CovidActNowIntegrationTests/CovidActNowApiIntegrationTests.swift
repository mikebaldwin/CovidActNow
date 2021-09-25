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
        var expectedData: StateData?
        
        // When
        let result = await covidActNowService.getDataFor(state: .Oregon)
        
        switch result {
        case let .success(resultData):
            expectedData = resultData
        case .failure:
            break
        }
        
        let stateData = try XCTUnwrap(expectedData)
        
        // Then
        XCTAssertEqual(stateData.abbreviation, "OR")
        XCTAssertEqual(stateData.fips, "41")
        XCTAssertTrue(stateData.population > 1_000_000)
    }
    
}
