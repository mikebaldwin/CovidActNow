//
//  SessionProvider.swift
//  CovidActNow
//
//  Created by Michael Baldwin on 9/26/21.
//

import Foundation

protocol SessionProviding {
    func sendRequest<T>(_ request: URLRequest, for decodable: T.Type) async -> Result<T, APIError> where T: Decodable
}

struct SessionProvider: SessionProviding {
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
