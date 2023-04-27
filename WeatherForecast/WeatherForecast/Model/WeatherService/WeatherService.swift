//
//  WeatherService.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 22/04/2023.
//

import Combine
import Foundation
import OSLog

class WeatherService: ObservableObject {
    @Published var weatherLoadingState: LoadingState<Weather> = .loading

    private let store: WeatherServiceStoreProtocol
    private var disposeBag = Set<AnyCancellable>()

    init() {
        Logger.default.info("[WeatherService] init")

        store = WeatherServiceStore()
    }

    deinit {
        Logger.default.info("[WeatherService] deinit")
    }

    @MainActor
    func getWeather(city: City) async throws {
        weatherLoadingState = .loading

        do {
            let weather = try await store.getWeather(city: city)
            weatherLoadingState = .loaded(weather)
        } catch {
            weatherLoadingState = .failed(error)
            weatherLoadingState = .idle
        }
    }
}

