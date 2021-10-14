//
//  StateData.swift
//  CovidActNow
//
//  Created by Michael Baldwin on 9/23/21.
//

import Foundation

struct LocationData: Decodable {
    let fips: String
    let country: String
    let state: String
    let county: String?
    let level: String
    let population: Int
    let metrics: CovidMetrics
    
    enum CodingKeys: String, CodingKey {
        case fips
        case country
        case state
        case county
        case level
        case population
        case metrics
    }    
}
