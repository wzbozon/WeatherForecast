//
//  WeatherService.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 22/04/2023.
//

import Combine
import Foundation
import OSLog

class WeatherRepository: ObservableObject {
    static let shared = WeatherRepository()
    
    @Published var weatherLoadingStates: [City: LoadingState<Weather>] = [:]

    private let store: WeatherService
    private var disposeBag = Set<AnyCancellable>()

    init() {
        Logger.default.info("[WeatherRepository] init")

        store = DefaultWeatherService()
    }

    deinit {
        Logger.default.info("[WeatherRepository] deinit")
    }

    @MainActor
    func getWeather(city: City) async throws {
        weatherLoadingStates[city] = .loading

        do {
            let weather = try await store.getWeather(city: city)
            weatherLoadingStates[city] = .loaded(weather)
        } catch {
            weatherLoadingStates[city] = .failed(error)
            weatherLoadingStates[city] = .idle
        }
    }
}

