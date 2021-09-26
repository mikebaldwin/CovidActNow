//
//  CovidActNowApi.swift
//  CovidActNow
//
//  Created by Michael Baldwin on 9/22/21.
//

import Foundation

struct CovidActNowService {
    private let sessionProvider: SessionProviding
    
    init(with sessionProvider: SessionProviding = SessionProvider()) {
        self.sessionProvider = sessionProvider
    }
    
    func getDataFor(state: State) async -> Result<LocationData, APIError> {
        let endpoint = StatesEndpoint(for: state)
        let result = await sessionProvider.sendRequest(endpoint.request, for: LocationData.self)
        return result
    }
    
    func getDataFor(county fips: Fips) async -> Result<CountyData, APIError> {
        return .failure(.noResult)
    }
}
