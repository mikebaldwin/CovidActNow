//
//  Endpoint.swift
//  CovidActNow
//
//  Created by Michael Baldwin on 9/24/21.
//

import Foundation

private extension String {
    static let apiKey = "6cef8ab3821b483a8d0ab990da2b02e3"
}

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem] { get }
    var request: URLRequest { get }
}

extension Endpoint {
    var scheme: String { "https" }
    var host: String { "api.covidactnow.org" }
    var queryItems: [URLQueryItem] {
        [URLQueryItem(name: "apiKey", value: .apiKey)]
    }
}
