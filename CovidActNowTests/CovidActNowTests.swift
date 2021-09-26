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

    func testGetDataForStateSuccess() async throws {
        // Given
        let service = CovidActNowService(with: MockSessionProvider())
        var expectedResult: StateData?
        
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
        // Then
        XCTAssertEqual(stateData.abbreviation, "OR")
        XCTAssertEqual(stateData.fips.stringValue, "41")
        XCTAssertEqual(stateData.fips.intValue, 41)
        XCTAssertTrue(stateData.population > 1_000_000)

    }

}
