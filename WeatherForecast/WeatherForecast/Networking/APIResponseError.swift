//
//  APIResponseError.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 22/04/2023.
//

import Foundation

struct APIResponseError: Codable {
    let code: Int?
    let message: String?
    let field: String?
}
