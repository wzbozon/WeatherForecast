//
//  RequestError.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 22/04/2023.
//

import Foundation

enum RequestError: Error {

    case networkError
    case decodingError(DecodingError)
    case invalidURL
    case noResponse

    var message: String {
        switch self {
        case .noResponse:
            return "No response"
        case .decodingError(let error):
            return "Decoding error" + ": \n" + error.message
        default:
            return "Unhandled error"
        }
    }

    var errorCode: Int? {
        switch self {
        default:
            return 403
        }
    }

    var statusCode: Int {
        switch self {
        case .noResponse:
            return 400
        default:
            return 403
        }
    }
}
