//
//  ServiceProvider.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 22/04/2023.
//

import Foundation

class ServiceProvider: ObservableObject {
    let weatherService: WeatherService

    init() {
        weatherService = .init()

        setupURLCache()
    }

    func setupURLCache() {
        URLCache.shared.memoryCapacity = 10_000_000 // ~10 MB memory space
        URLCache.shared.diskCapacity = 1_000_000_000 // ~1GB disk cache space
    }
}
