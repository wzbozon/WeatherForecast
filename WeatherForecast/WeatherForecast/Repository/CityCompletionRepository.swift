//
//  CityCompletionRepository.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 23/04/2023.
//

import Combine
import SwiftUI

class CityCompletionRepository: ObservableObject {
    @Published var predictions: [CityPrediction] = []

    private var cityCompletionService: CityCompletionService
    
    init() {
        predictions = []
        cityCompletionService = DefaultCityCompletionService()
    }
    
    func search(_ search: String) {
        cityCompletionService.getCompletion(for: search) { (predictions) in
            DispatchQueue.main.async {
                self.predictions = predictions
            }
        }
    }
}
