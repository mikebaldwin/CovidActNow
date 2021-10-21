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
                
        // When
        let stateData = try await service.getDataFor(state: .oregon)
        let metrics = stateData.metrics

        // Then
        XCTAssertEqual(stateData.fips, "41")
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

        let countyData = try await service.getDataFor(county: .multnomah)
        let metrics = countyData.metrics
        
        // Then
        XCTAssertEqual(countyData.fips, "41051")
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
