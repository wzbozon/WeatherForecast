//
//  CityListViewModel.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 27/04/2023.
//

import Combine
import Factory
import Foundation

class CityListViewModel: ObservableObject {

    @Published var cities: [City] = []

    @Injected(\.cityRepository) private var cityRepository

    init() {
        setupSubscriptions()
    }

    func delete(at offsets: IndexSet) {
        for index in offsets {
            cityRepository.deleteCity(cityRepository.cities[index])
        }
    }

    func selectCity(_ city: City) {
        cityRepository.selectCity(city)
    }

    private var disposeBag = Set<AnyCancellable>()
}

// MARK: - Private

private extension CityListViewModel {
    func setupSubscriptions() {
        cityRepository.$cities
            .assign(to: \.cities, on: self)
            .store(in: &disposeBag)
    }
}
