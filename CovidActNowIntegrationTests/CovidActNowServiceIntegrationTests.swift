//
//  CovidActNowApiIntegrationTests.swift
//  CovidActNowIntegrationTests
//
//  Created by Michael Baldwin on 9/22/21.
//

import XCTest
@testable import CovidActNow

class CovidActNowServiceIntegrationTests: XCTestCase {
    func testGetStateDataForOregon() async throws {
        // Given
        let covidActNowService = CovidActNowService()
        var expectedResult: LocationData?
        
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
        XCTAssertEqual(stateData.state, "OR")
        XCTAssertEqual(stateData.fips.stringValue, "41")
        XCTAssertEqual(stateData.fips.intValue, 41)
        XCTAssertTrue(stateData.population > 1_000_000)
    
    func testGetCountyDataForMultnomah() async throws {
        // Given
        let service = CovidActNowService()
        var expectedResult: LocationData?
        
        // When
        let result = await service.getDataFor(county: .multnomah)
        
        switch result {
        case let .success(resultData):
            expectedResult = resultData
        case let .failure(error):
            XCTFail("Session failed with error: \(error)")
        }

        let countyData = try XCTUnwrap(expectedResult)
        
        // Then
        XCTAssertEqual(countyData.fips.stringValue, "41051")
        XCTAssertEqual(countyData.fips.intValue, 41051)
        XCTAssertEqual(countyData.country, "US")
        XCTAssertEqual(countyData.state, "OR")
        XCTAssertEqual(countyData.county, "Multnomah County")
        XCTAssertEqual(countyData.level, "county")
        XCTAssertTrue(countyData.population > 0)
        XCTAssertNotNil(countyData.metrics)
    }
}
