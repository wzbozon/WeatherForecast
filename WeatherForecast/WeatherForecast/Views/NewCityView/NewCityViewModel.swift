//
//  NewCityViewModel.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 27/04/2023.
//

import Combine
import Factory
import Foundation

class NewCityViewModel: ObservableObject {

    @Published var isValidating: Bool = false
    @Published var predictions: [CityPrediction] = []

    @Injected(\.cityRepository) private var cityRepository
    @Injected(\.cityAutocompleteRepository) private var cityAutocompleteRepository

    init() {
        setupSubscriptions()
    }

    func addCity(from prediction: CityPrediction) {
        isValidating = true

        DefaultCityValidationService.validateCity(withID: prediction.id) { cityData in
            if let cityData {
                DispatchQueue.main.async {
                    self.cityRepository.addCity(cityData: cityData)
                }
            }

            DispatchQueue.main.async {
                self.isValidating = false
            }
        }
    }

    func search(_ text: String) {
        cityAutocompleteRepository.search(text)
    }

    private var disposeBag = Set<AnyCancellable>()
}

private extension NewCityViewModel {
    func setupSubscriptions() {
        cityAutocompleteRepository.$predictions
            .assign(to: \.predictions, on: self)
            .store(in: &disposeBag)
    }
}
