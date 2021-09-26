//
//  Fips.swift
//  CovidActNow
//
//  Created by Michael Baldwin on 9/23/21.
//

import Foundation

/// Federal Information Processing Standards code used to identify states and counties
/// Can be initialize with a string literal
struct Fips {
    let stringValue: String
    let intValue: Int
    
    init(with string: String) {
        precondition(string.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil, "Input must be numeric, only.")
        stringValue = string
        // Given the precondition, initializing an Int from the string should never fail.
        intValue = Int(string)!
    }
    
    init(with int: Int) {
        intValue = int
        stringValue = "\(int)"
    }
    
}

extension Fips: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self = Fips(with: value)
    }
}
