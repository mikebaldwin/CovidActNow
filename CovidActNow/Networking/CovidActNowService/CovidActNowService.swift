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
    
    func getDataFor(state: State) async throws -> LocationData {
        let endpoint = StateEndpoint(for: state)
        do {
            let result = try await sessionProvider.sendRequest(endpoint.request, for: LocationData.self)
            return result
        } catch {
            throw error
        }
    }
    
    func getDataFor(county: County) async throws -> LocationData {
        let endpoint = CountyEndpoint(for: county)
        do {
            let result = try await sessionProvider.sendRequest(endpoint.request, for: LocationData.self)
            return result
        } catch {
            throw error
        }
    }
}
