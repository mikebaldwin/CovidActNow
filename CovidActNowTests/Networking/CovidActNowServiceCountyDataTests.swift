//
//  CovidActNowServiceCountyDataTests.swift
//  CovidActNowTests
//
//  Created by Michael Baldwin on 11/10/21.
//

import XCTest
@testable import CovidActNow

class CovidActNowServiceCountyDataTests: XCTestCase {
    private var service = CovidActNowService(with: MockCountyDataSessionProvider())
    private var countyData: LocationData!
    
    override func setUp() async throws {
        let expectedData = try await service.getDataFor(state: .oregon)
        countyData = try XCTUnwrap(expectedData)
    }

    func testDataForCounty() {
        XCTAssertEqual(countyData.fips, "41051")
        XCTAssertEqual(countyData.country, "US")
        XCTAssertEqual(countyData.state, "OR")
        XCTAssertEqual(countyData.county, "Multnomah County")
        XCTAssertEqual(countyData.level, "county")
        XCTAssertEqual(countyData.population, 812855)
        XCTAssertNotNil(countyData.metrics)
    }

    func testMetricsForCounty() {
        let metrics = countyData.metrics
        
        XCTAssertEqual(metrics.testPositivityRatio, 0.059)
        XCTAssertEqual(metrics.caseDensity, 19.2)
        XCTAssertEqual(metrics.infectionRate, 0.92)
        XCTAssertEqual(metrics.icuCapacityRatio, 0.81)
        XCTAssertEqual(metrics.vaccinationsInitiatedRatio, 0.759)
        XCTAssertEqual(metrics.vaccinationsCompletedRatio, 0.69)
    }
    
    func testRiskLevelForCounty() {
        let riskLevel = countyData.riskLevel
        
        XCTAssertEqual(riskLevel, RiskLevel.high)
    }
}
