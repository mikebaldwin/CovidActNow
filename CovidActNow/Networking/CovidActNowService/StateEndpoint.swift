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
    
    init(for state: State) {
        path = "/v2/state/\(state.rawValue).json"
        method = HTTPMethod.get
    }
}
