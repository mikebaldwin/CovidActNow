//
//  StateEndpoint.swift
//  CovidActNow
//
//  Created by Michael Baldwin on 9/26/21.
//

import Foundation

struct StateEndpoint: Endpoint {
    var path: String
    var method: HTTPMethod
    
    var request: URLRequest {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = queryItems

        guard let url = components.url else {
            fatalError("Failed to construct a valid url from components.")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        return request
    }
    
    init(for state: State) {
        path = "/v2/state/\(state.rawValue).json"
        method = HTTPMethod.get
    }
}
