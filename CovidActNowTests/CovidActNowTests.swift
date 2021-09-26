//
//  CovidActNowTests.swift
//  CovidActNowTests
//
//  Created by Michael Baldwin on 9/22/21.
//

import XCTest
@testable import CovidActNow

class CovidActNowTests: XCTestCase {

    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        
    }

    func testGetDataForState() async throws {
        // Given
        let service = CovidActNowService(with: MockStateDataSessionProvider())
        var expectedResult: LocationData?
        
        // When
        let result = await service.getDataFor(state: .Oregon)
        
        switch result {
        case let .success(resultData):
            expectedResult = resultData
        case let .failure(error):
            XCTFail("Mock session failed with error: \(error)")
        }
        
        let stateData = try XCTUnwrap(expectedResult)

        // Then
        XCTAssertEqual(stateData.fips.stringValue, "41")
        XCTAssertEqual(stateData.fips.intValue, 41)
        XCTAssertEqual(stateData.country, "US")
        XCTAssertEqual(stateData.state, "OR")
        XCTAssertNil(stateData.county)
        XCTAssertEqual(stateData.level, "state")
        XCTAssertEqual(stateData.population, 4217737)
        XCTAssertNotNil(stateData.metrics)
    }

}
