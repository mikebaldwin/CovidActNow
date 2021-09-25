//
//  APIError.swift
//  CovidActNow
//
//  Created by Michael Baldwin on 9/22/21.
//

import Foundation

enum APIError: Error {
    case noResult
    case jsonDecodingFailed
    case dataDownloadFailed
}
