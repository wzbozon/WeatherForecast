//
//  Endpoint.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 22/04/2023.
//

import Foundation

enum Server {
    case openmeteo(String)
}

protocol Endpoint {
    var path: String { get }
    var requestType: RequestType { get }
    var header: [String: String]? { get }
    var parameters: [String: Any]? { get }
    var url: URL? { get }
    var server: Server { get }
}

extension Endpoint {
    // Default HTTP headers
    var header: [String: String]? {
        let output =
        [
            "Content-Type": "application/json",
            "Accept": "*/*"
        ]

        return output
    }

    var url: URL? {
        var urlString: String

        switch server {
        case .openmeteo(let baseURL):
            urlString = baseURL + path
        }

        return URL(string: urlString)
    }

    /// Default server is Open-Meteo server
    /// On server depends how we parse a response and create a URL
    var server: Server {
        return .openmeteo(ServerEnvironment.current.url)
    }
}
