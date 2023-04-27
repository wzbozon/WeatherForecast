//
//  RequestError.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 22/04/2023.
//

import Foundation

enum RequestError: Error {
    case statusNotOk
    case decodingError(DecodingError)
    case invalidURL
    case noResponse
    case unexpectedStatusCode
    case unknown(Data)

    var message: String {
        switch self {
        case .unknown(let data):
            let error = data.decode(model: APIResponse<APIResponseError>.self)
            let errorMessage = error?.errors.map { $0.compactMap { $0.message } }
            return errorMessage?.reduce("", { $0 + "\n" + $1 }) ?? "Error with request"
        case .noResponse:
            return NSLocalizedString("error.no.response", comment: "")
        case .decodingError(let error):
            return NSLocalizedString("error.decoding", comment: "") + ": \n" + error.message
        default:
            return NSLocalizedString("error.unhandled", comment: "")
        }
    }

    var errorCode: Int? {
        switch self {
        case .unknown(let data):
            let error = data.decode(model: APIResponse<APIResponseError>.self)
            let errorCode = error?.errors.map { $0.compactMap { $0.code } }
            return errorCode?.first
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
