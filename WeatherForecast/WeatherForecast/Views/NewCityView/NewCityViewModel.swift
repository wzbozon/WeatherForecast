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
    @Published var predictions: [CityCompletion.Prediction] = []

    init(cityStore: CityStore = .shared, completer: CityCompletion = .init()) {
        self.cityStore = cityStore
        self.completer = completer

        setupSubscriptions()
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

    func search(_ text: String) {
        completer.search(text)
    }

    private var disposeBag = Set<AnyCancellable>()
    private let cityStore: CityStore
    private let completer: CityCompletion
}

private extension NewCityViewModel {
    func setupSubscriptions() {
        completer.$predictions
            .assign(to: \.predictions, on: self)
            .store(in: &disposeBag)
    }
}
