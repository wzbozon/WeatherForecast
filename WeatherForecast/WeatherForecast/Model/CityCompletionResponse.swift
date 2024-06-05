//
//  CityCompletionResponse.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 23/04/2023.
//

import Foundation

struct CityCompletionResponse: Codable {
    var predictions: [CityPrediction]

    enum CodingKeys: String, CodingKey {
        case predictions = "predictions"
    }
}

struct CityPrediction: Codable, Identifiable {
    var id: String
    var description: String

    enum CodingKeys: String, CodingKey {
        case id = "place_id"
        case description = "description"
    }
}
