//
//  SessionProvider.swift
//  CovidActNow
//
//  Created by Michael Baldwin on 9/26/21.
//

import Foundation

protocol SessionProviding {
    func sendRequest<T>(_ request: URLRequest, for decodable: T.Type) async throws -> T where T: Decodable
}

struct SessionProvider: SessionProviding {
    func sendRequest<T>(_ request: URLRequest, for decodable: T.Type) async throws -> T where T: Decodable {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        var response: (data: Data, urlResponse: URLResponse)
        
        do {
            response = try await session.data(for: request)
        } catch {
            throw ServiceError.dataDownloadFailed
        }
        
        do {
            try validate(response.urlResponse)
        } catch {
            throw error
        }
        
        do {
            let decodedData = try JSONDecoder().decode(decodable, from: response.data)
            return decodedData
        } catch {
            throw ServiceError.jsonDecodingFailed
        }
    }
}

private extension SessionProvider {
    func validate(_ urlResponse: URLResponse) throws {
        guard let httpResponse = urlResponse as? HTTPURLResponse
        else {
            throw ServiceError.unknownError
        }
        
        switch httpResponse.statusCode {
        case 200:
            return
        case 403:
            throw ServiceError.accessDenied
        default:
            throw ServiceError.unknownError
        }
    }
}
