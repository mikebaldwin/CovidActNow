//
//  MockStateDataSessionProvider.swift
//  CovidActNowTests
//
//  Created by Michael Baldwin on 9/26/21.
//

import Foundation
@testable import CovidActNow

class MockStateDataSessionProvider: SessionProviding {
    func sendRequest<T>(_ request: URLRequest, for decodable: T.Type) async throws -> T where T : Decodable {
        guard let bundlePath = Bundle(for: type(of: self)).path(forResource: "StateData", ofType: "json")
        else {
            throw ServiceError.noResult
        }
        guard let json = try? String(contentsOfFile: bundlePath).data(using: .utf8)
        else {
            throw ServiceError.dataDownloadFailed
        }
        guard let stateData = try? JSONDecoder().decode(LocationData.self, from: json)
        else {
            throw ServiceError.jsonDecodingFailed
        }
        
        return stateData as! T
    }
}
