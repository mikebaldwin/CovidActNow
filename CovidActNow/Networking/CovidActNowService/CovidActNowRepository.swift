//
//  CovidActNowApi.swift
//  CovidActNow
//
//  Created by Michael Baldwin on 9/22/21.
//

import Foundation

struct CovidActNowRepository {
    private let sessionProvider: SessionProviding
    
    init(with sessionProvider: SessionProviding = SessionProvider()) {
        self.sessionProvider = sessionProvider
    }
    
    func getDataFor(state: State) async throws -> LocationData {
        let endpoint = StateEndpoint(for: state)
        let result = try await sessionProvider.sendRequest(
            endpoint.request,
            for: LocationData.self
        )
        return result
    }
    
    func getDataFor(county: County) async throws -> LocationData {
        let endpoint = CountyEndpoint(for: county)
        let result = try await sessionProvider.sendRequest(
            endpoint.request,
            for: LocationData.self
        )
        return result
    }
}
