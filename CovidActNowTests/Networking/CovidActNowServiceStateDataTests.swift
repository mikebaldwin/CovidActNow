//
//  CovidActNowServiceStateDataTests.swift
//  CovidActNowTests
//
//  Created by Michael Baldwin on 9/22/21.
//

import XCTest
@testable import CovidActNow

class CovidActNowServiceStateDataTests: XCTestCase {
    private var service = CovidActNowService(with: MockStateDataSessionProvider())
    private var stateData: LocationData!
    
    override func setUp() async throws {
        let expectedData = try await service.getDataFor(state: .oregon)
        stateData = try XCTUnwrap(expectedData)
    }
    
    func testDataForState() {
        XCTAssertEqual(stateData.fips, "41")
        XCTAssertEqual(stateData.country, "US")
        XCTAssertEqual(stateData.state, "OR")
        XCTAssertNil(stateData.county)
        XCTAssertEqual(stateData.level, "state")
        XCTAssertEqual(stateData.population, 4217737)
    }
    
    func testGetMetricsForState() {
        let metrics = stateData.metrics

        XCTAssertEqual(metrics.testPositivityRatio, 0.084)
        XCTAssertEqual(metrics.caseDensity, 37.8)
        XCTAssertEqual(metrics.infectionRate, 0.96)
        XCTAssertEqual(metrics.icuCapacityRatio, 0.77)
        XCTAssertEqual(metrics.vaccinationsInitiatedRatio, 0.662)
        XCTAssertEqual(metrics.vaccinationsCompletedRatio, 0.603)
    }
    
    func testGetRiskLevelForState() {
        let riskLevel = stateData.riskLevel
        
        XCTAssertEqual(riskLevel, RiskLevel.veryHigh)
    }    
}
