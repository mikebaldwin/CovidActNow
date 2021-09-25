//
//  CountyData.swift
//  CovidActNow
//
//  Created by Michael Baldwin on 9/22/21.
//

import Foundation

struct CountyData: Decodable {
    let county: String
    
    enum CodingKeys: String, CodingKey {
        case county
    }
}
