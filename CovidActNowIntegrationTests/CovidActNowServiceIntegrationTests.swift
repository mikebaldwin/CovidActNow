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
                
        // When
        let stateData = try await covidActNowService.getDataFor(state: .oregon)
                
        // Then
        XCTAssertEqual(stateData.fips, "41")
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
        
        // When
        let countyData = try await service.getDataFor(county: .multnomah)
                
        // Then
        XCTAssertEqual(countyData.fips, "41051")
        XCTAssertEqual(countyData.country, "US")
        XCTAssertEqual(countyData.state, "OR")
        XCTAssertEqual(countyData.county, "Multnomah County")
        XCTAssertEqual(countyData.level, "county")
        XCTAssertTrue(countyData.population > 0)
        XCTAssertNotNil(countyData.metrics)
    }
    
    func testGetDataForInvalidFips() async throws {
        let service = CovidActNowService()
        await XCTAssertThrowsError(try await service.getDataFor(county: .invalidCounty))
    }
}

extension XCTest {
    func XCTAssertThrowsError<T: Sendable>(
        _ expression: @autoclosure () async throws -> T,
        _ message: @autoclosure () -> String = "",
        file: StaticString = #filePath,
        line: UInt = #line,
        _ errorHandler: (_ error: Error) -> Void = { _ in }
    ) async {
        do {
            _ = try await expression()
            XCTFail(message(), file: file, line: line)
        } catch {
            errorHandler(error)
        }
    }
}
