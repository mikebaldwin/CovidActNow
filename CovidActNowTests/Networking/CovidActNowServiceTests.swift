//
//  CovidActNowServiceTests.swift
//  CovidActNowTests
//
//  Created by Michael Baldwin on 9/22/21.
//

import XCTest
@testable import CovidActNow

class CovidActNowServiceTests: XCTestCase {
    func testGetDataForState() async throws {
        // Given
        let service = CovidActNowService(with: MockStateDataSessionProvider())
        var expectedResult: LocationData?
        
        // When
        let result = await service.getDataFor(state: .oregon)
        
        switch result {
        case let .success(resultData):
            expectedResult = resultData
        case let .failure(error):
            XCTFail("Mock session failed with error: \(error)")
        }
        
        let stateData = try XCTUnwrap(expectedResult)
        let metrics = stateData.metrics

        // Then
        XCTAssertEqual(stateData.fips.stringValue, "41")
        XCTAssertEqual(stateData.fips.intValue, 41)
        XCTAssertEqual(stateData.country, "US")
        XCTAssertEqual(stateData.state, "OR")
        XCTAssertNil(stateData.county)
        XCTAssertEqual(stateData.level, "state")
        XCTAssertEqual(stateData.population, 4217737)
        
        XCTAssertEqual(metrics.testPositivityRatio, 0.084)
        XCTAssertEqual(metrics.caseDensity, 37.8)
        XCTAssertEqual(metrics.infectionRate, 0.96)
        XCTAssertEqual(metrics.icuCapacityRatio, 0.77)
        XCTAssertEqual(metrics.vaccinationsInitiatedRatio, 0.662)
        XCTAssertEqual(metrics.vaccinationsCompletedRatio, 0.603)
    }
    
    func testGetDataForCounty() async throws {
        // Given
        let service = CovidActNowService(with: MockCountyDataSessionProvider())
        var expectedResult: LocationData?
        
        // When
        let result = await service.getDataFor(county: .multnomah)
        
        switch result {
        case let .success(resultData):
            expectedResult = resultData
        case let .failure(error):
            XCTFail("Mock session failed with error: \(error)")
        }

        let countyData = try XCTUnwrap(expectedResult)
        let metrics = countyData.metrics
        
        // Then
        XCTAssertEqual(countyData.fips.stringValue, "41051")
        XCTAssertEqual(countyData.fips.intValue, 41051)
        XCTAssertEqual(countyData.country, "US")
        XCTAssertEqual(countyData.state, "OR")
        XCTAssertEqual(countyData.county, "Multnomah County")
        XCTAssertEqual(countyData.level, "county")
        XCTAssertEqual(countyData.population, 812855)
        XCTAssertNotNil(countyData.metrics)
        
        XCTAssertEqual(metrics.testPositivityRatio, 0.059)
        XCTAssertEqual(metrics.caseDensity, 19.2)
        XCTAssertEqual(metrics.infectionRate, 0.92)
        XCTAssertEqual(metrics.icuCapacityRatio, 0.81)
        XCTAssertEqual(metrics.vaccinationsInitiatedRatio, 0.759)
        XCTAssertEqual(metrics.vaccinationsCompletedRatio, 0.69)
    }
}
