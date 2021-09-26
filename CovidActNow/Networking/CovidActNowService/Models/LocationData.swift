//
//  StateData.swift
//  CovidActNow
//
//  Created by Michael Baldwin on 9/23/21.
//

import Foundation

struct LocationData: Decodable {
    let fips: Fips
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
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let fipsValue = try container.decode(String.self, forKey: CodingKeys.fips)
        fips = Fips(with: fipsValue)

        country = try container.decode(String.self, forKey: CodingKeys.country)
        state = try container.decode(String.self, forKey: CodingKeys.state)
        county = try container.decodeIfPresent(String.self, forKey: CodingKeys.county)
        level = try container.decode(String.self, forKey: CodingKeys.level)
        population = try container.decode(Int.self, forKey: CodingKeys.population)
        metrics = try container.decode(CovidMetrics.self, forKey: CodingKeys.metrics)
    }
}
