//
//  WeatherViewModel.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 27/04/2023.
//

import Combine
import Foundation

@MainActor
final class WeatherViewModel: ObservableObject {
    @Published var isShowingError = false
    @Published var errorMessage: String?
    @Published var cities: [City] = []
    @Published var isShowingCityListView = false
    @Published var page = 0

    init(cityRepository: CityRepository = .shared) {
        self.cityRepository = cityRepository

        setupSubscriptions()
    }

    func showCityListView() {
        isShowingCityListView = true
    }

    private var disposeBag = Set<AnyCancellable>()
    private let cityRepository: CityRepository
}

// MARK: - Private

private extension WeatherViewModel {
    func setupSubscriptions() {
        cityRepository.$cities
            .assign(to: \.cities, on: self)
            .store(in: &disposeBag)

        cityRepository.$selectedCity
            .compactMap { $0 }
            .map { city in
                self.cities.firstIndex(where: { $0.name == city.name }) ?? 0
            }
            .assign(to: \.page, on: self)
            .store(in: &disposeBag)
    }
}
