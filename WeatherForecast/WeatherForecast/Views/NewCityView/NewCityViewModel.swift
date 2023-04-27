//
//  NewCityViewModel.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 27/04/2023.
//

import Foundation

class NewCityViewModel: ObservableObject {
    @Published var isValidating: Bool = false

    init(cityStore: CityStore = .shared) {
        self.cityStore = cityStore
    }

    func addCity(from prediction: CityCompletion.Prediction) {
        isValidating = true

        CityValidation.validateCity(withID: prediction.id) { cityData in
            if let cityData {
                DispatchQueue.main.async {
                    self.cityStore.addCity(cityData: cityData)
                }
            }

            DispatchQueue.main.async {
                self.isValidating = false
            }
        }
    }

    private let cityStore: CityStore
}
