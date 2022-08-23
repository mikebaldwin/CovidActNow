//
//  SessionProvider.swift
//  CovidActNow
//
//  Created by Michael Baldwin on 9/26/21.
//

import Foundation

protocol SessionProviding {
    func sendRequest<T>(
        _ request: URLRequest,
        for decodable: T.Type
    ) async throws -> T where T: Decodable
}

struct SessionProvider: SessionProviding {
    func sendRequest<T>(
        _ request: URLRequest,
        for decodable: T.Type
    ) async throws -> T where T: Decodable {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        var response: (data: Data, urlResponse: URLResponse)
        
        response = try await session.data(for: request)
        
        guard is200(response.urlResponse) else {
            throw error(for: response.urlResponse)
        }
        
        let decodedData = try JSONDecoder().decode(decodable, from: response.data)
        
        return decodedData
    }
}

private extension SessionProvider {
    func is200(_ urlResponse: URLResponse) -> Bool {
        guard let httpResponse = urlResponse as? HTTPURLResponse else {
            return false
        }
        
        let isOk = (200...299).contains(httpResponse.statusCode)
        
        return isOk
    }
    
    func error(for urlResponse: URLResponse) -> ServiceError {
        guard let httpResponse = urlResponse as? HTTPURLResponse
        else {
            return ServiceError.unknownError
        }

        switch httpResponse.statusCode {
        case 403:
            return ServiceError.accessDenied
        default:
            return ServiceError.unknownError
        }
    }
}
