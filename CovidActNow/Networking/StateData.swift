//
//  StateData.swift
//  CovidActNow
//
//  Created by Michael Baldwin on 9/23/21.
//

import Foundation

struct StateData: Decodable {
    let abbreviation: String
    // TODO: decode as fips object
    let fips: String
    let population: Int
    let metrics: CovidMetrics
    
    enum CodingKeys: String, CodingKey {
        case fips
        case abbreviation = "state"
        case population
        case metrics
    }
}

struct CovidMetrics: Decodable {
    let testPositivityRatio: Double
    let caseDensity: Double
    let infectionRate: Double
    let icuCapacityRatio: Double
    let vaccinationsInitiatedRatio: Double
    let vaccinationsCompletedRatio: Double
    
    enum CodingKeys: String, CodingKey {
        case testPositivityRatio
        case caseDensity
        case infectionRate
        case icuCapacityRatio
        case vaccinationsInitiatedRatio
        case vaccinationsCompletedRatio
    }
}
