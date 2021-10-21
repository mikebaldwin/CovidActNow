//
//  APIError.swift
//  CovidActNow
//
//  Created by Michael Baldwin on 9/22/21.
//

import Foundation

enum ServiceError: Error {
    case noResult
    case jsonDecodingFailed
    case dataDownloadFailed
    case accessDenied
    case unknownError
}
