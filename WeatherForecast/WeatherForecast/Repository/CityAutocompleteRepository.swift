//
//  CityAutocompleteRepository.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 23/04/2023.
//

import Combine
import OSLog
import SwiftUI

class CityAutocompleteRepository: ObservableObject {

    @Published var predictions: [CityPrediction] = []

    private var cityAutocompleteService: CityAutocompleteService
    
    init() {
        Logger.default.info("[CityAutocompleteRepository] init")

        predictions = []
        cityAutocompleteService = DefaultCityAutocompleteService()
    }

    deinit {
        Logger.default.info("[CityAutocompleteRepository] deinit")
    }

    func search(_ search: String) {
        cityAutocompleteService.getCompletion(for: search) { (predictions) in
            DispatchQueue.main.async {
                self.predictions = predictions
            }
        }
    }
}
