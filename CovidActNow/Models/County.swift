//
//  Counties.swift
//  CovidActNow
//
//  Created by Michael Baldwin on 9/26/21.
//

import Foundation

enum County: String {
    case multnomah = "41051"
    case invalidCounty = "00000"
    
    var fips: Fips {
        switch self {
        case .multnomah:
            let value = County.multnomah.rawValue
            return Fips(with: value)
        case .invalidCounty:
            let value = County.invalidCounty.rawValue
            return Fips(with: value)
        }
    }
}
