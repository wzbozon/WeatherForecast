//
//  NewCityViewModel.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 27/04/2023.
//

import Combine
import Foundation

class NewCityViewModel: ObservableObject {
    @Published var isValidating: Bool = false
    @Published var predictions: [CityPrediction] = []

    init(
        cityRepository: CityRepository = .shared,
        cityCompletionRepository: CityCompletionRepository = .init()
    ) {
        self.cityRepository = cityRepository
        self.cityCompletionRepository = cityCompletionRepository

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
        cityCompletionRepository.search(text)
    }

    private var disposeBag = Set<AnyCancellable>()
    private let cityRepository: CityRepository
    private let cityCompletionRepository: CityCompletionRepository
}

private extension NewCityViewModel {
    func setupSubscriptions() {
        cityCompletionRepository.$predictions
            .assign(to: \.predictions, on: self)
            .store(in: &disposeBag)
    }
}
