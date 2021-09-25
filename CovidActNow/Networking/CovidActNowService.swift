//
//  CovidActNowApi.swift
//  CovidActNow
//
//  Created by Michael Baldwin on 9/22/21.
//

import Foundation

protocol CovidActNowServiceProvider {
    func getDataFor(state: State) async -> Result<StateData, APIError>
    func getDataFor(county fips: Fips) async -> Result<CountyData, APIError>
}

struct CovidActNowService: CovidActNowServiceProvider {
    func getDataFor(state: State) async -> Result<StateData, APIError> {
        let endpoint = StatesEndpoint(for: state)
        let result = await sendRequest(endpoint.request, for: StateData.self)
        return result
    }
    
    func getDataFor(county fips: Fips) async -> Result<CountyData, APIError> {
        
    }
}

private extension CovidActNowService {
    func sendRequest<T>(_ request: URLRequest, for decodable: T.Type) async -> Result<T, APIError> where T: Decodable {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        var response: (data: Data, urlResponse: URLResponse)
        
        do {
            response = try await session.data(for: request)
        } catch {
            return .failure(.dataDownloadFailed)
        }
        
        do {
            let decodedData = try JSONDecoder().decode(decodable, from: response.data)
            return .success(decodedData)
        } catch {
            return .failure(.jsonDecodingFailed)
        }
    }
}
