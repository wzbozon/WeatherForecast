//
//  CityCompletionResult.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 23/04/2023.
//

import SwiftUI

extension CityCompletion {
    struct Result: Codable {
        var predictions: [Prediction]
        
        enum CodingKeys: String, CodingKey {
            case predictions = "predictions"
        }
    }
    
    struct Prediction: Codable, Identifiable {
        var id: String
        var description: String
        
        enum CodingKeys: String, CodingKey {
            case id = "place_id"
            case description = "description"
        }
    }
}
