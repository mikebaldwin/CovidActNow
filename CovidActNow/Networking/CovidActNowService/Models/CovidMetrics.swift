//
//  CovidMetrics.swift
//  CovidActNow
//
//  Created by Michael Baldwin on 9/26/21.
//

import Foundation

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
