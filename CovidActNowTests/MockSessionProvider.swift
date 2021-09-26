//
//  MockSessionProvider.swift
//  CovidActNowTests
//
//  Created by Michael Baldwin on 9/26/21.
//

import Foundation
@testable import CovidActNow
import SwiftUI

class MockSessionProvider: SessionProviding {
    func sendRequest<T>(_ request: URLRequest, for decodable: T.Type) async -> Result<T, APIError> where T : Decodable {
        guard let bundlePath = Bundle(for: type(of: self)).path(forResource: "StateData", ofType: "json")
        else {
            return .failure(.noResult)
        }
        guard let json = try? String(contentsOfFile: bundlePath).data(using: .utf8)
        else {
            return .failure(.dataDownloadFailed)
        }
        guard let stateData = try? JSONDecoder().decode(StateData.self, from: json)
        else {
            return .failure(.jsonDecodingFailed)
        }
        
        return .success(stateData as! T)
    }
}
