//
//  APIResponse.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 22/04/2023.
//

import Foundation

struct APIResponse<T: Codable>: Codable {
    let status: Int?
    let code: Int?
    let message: String?
    let errors: [APIResponseError]?
    let data: T?
}
