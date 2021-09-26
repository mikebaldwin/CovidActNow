//
//  CountyEndpoint.swift
//  CovidActNow
//
//  Created by Michael Baldwin on 9/25/21.
//

import Foundation

struct CountyEndpoint: Endpoint {
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
    
    init(for county: County) {
        path = "/v2/county/\(county.fips.stringValue).json"
        method = HTTPMethod.get
    }
}
