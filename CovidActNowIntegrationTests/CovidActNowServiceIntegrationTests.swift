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
        let result = await covidActNowService.getDataFor(state: .oregon)
        
        switch result {
        case let .success(resultData):
            expectedResult = resultData
        case let .failure(error):
            XCTFail("Session failed with error: \(error)")
        }
        
        let stateData = try XCTUnwrap(expectedResult)
        
        // Then
        XCTAssertEqual(stateData.fips.stringValue, "41")
        XCTAssertEqual(stateData.fips.intValue, 41)
        XCTAssertEqual(stateData.country, "US")
        XCTAssertEqual(stateData.state, "OR")
        XCTAssertNil(stateData.county)
        XCTAssertEqual(stateData.level, "state")
        XCTAssertTrue(stateData.population > 0)
        XCTAssertNotNil(stateData.metrics)
    }
    
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
    
    func testGetDataForInvalidFips() async throws {
        // Given
        let service = CovidActNowService()
        var expectedError: APIError?
        
        // When
        let result = await service.getDataFor(county: .invalidCounty)
        
        switch result {
        case .success:
            XCTFail("Call resulted in a success, and should not have.")
        case let .failure(error):
            expectedError = error
        }
        
        let invalidRequestError = try XCTUnwrap(expectedError)

        // Then
        XCTAssertEqual(invalidRequestError, APIError.accessDenied)
    }
}

