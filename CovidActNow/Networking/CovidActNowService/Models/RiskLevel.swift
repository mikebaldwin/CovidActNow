//
//  RiskLevel.swift
//  CovidActNow
//
//  Created by Michael Baldwin on 11/10/21.
//

import Foundation

enum RiskLevel: Int, Decodable {
    case low = 0
    case medium = 1
    case high = 2
    case veryHigh = 3
    case severe = 4
    
    enum CodingKeys: String, CodingKey {
        case overall
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let overall = try container.decode(Int.self, forKey: .overall)
        
        guard let riskLevel = RiskLevel(rawValue: overall)
        else {
            throw DecodingError.dataCorrupted(
                DecodingError.Context(
                    codingPath: [CodingKeys.overall],
                    debugDescription: "Unable to initialize RiskLevel enum case from downloaded value",
                    underlyingError: nil
                )
            )
        }
        
        self = riskLevel
    }
}
