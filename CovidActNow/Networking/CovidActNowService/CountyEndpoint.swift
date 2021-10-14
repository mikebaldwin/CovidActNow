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
    
    init(for county: County) {
        path = "/v2/county/\(county.rawValue).json"
        method = HTTPMethod.get
    }
}
