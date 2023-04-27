//
//  CityListViewModel.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 27/04/2023.
//

import Combine
import Foundation

class CityListViewModel: ObservableObject {
    @Published var cities: [City] = []

    init(cityStore: CityStore = .shared) {
        self.cityStore = cityStore

        setupSubscriptions()
    }

    func delete(at offsets: IndexSet) {
        for index in offsets {
            cityStore.deleteCity(cityStore.cities[index])
        }
    }

    func selectCity(_ city: City) {
        cityStore.selectCity(city)
    }

    private var disposeBag = Set<AnyCancellable>()
    private let cityStore: CityStore
}

// MARK: - Private

private extension CityListViewModel {
    func setupSubscriptions() {
        cityStore.$cities
            .assign(to: \.cities, on: self)
            .store(in: &disposeBag)
    }
}
