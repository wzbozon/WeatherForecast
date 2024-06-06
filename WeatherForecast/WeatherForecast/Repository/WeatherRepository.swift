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

    @Published var weatherLoadingStates: [City: LoadingState<Weather>] = [:]

    private let weatherService: WeatherService
    private var disposeBag = Set<AnyCancellable>()

    init() {
        Logger.default.info("[WeatherRepository] init")

        weatherService = DefaultWeatherService()
    }

    deinit {
        Logger.default.info("[WeatherRepository] deinit")
    }

    @MainActor
    func getWeather(city: City) async throws {
        weatherLoadingStates[city] = .loading

        do {
            let weather = try await weatherService.getWeather(city: city)
            weatherLoadingStates[city] = .loaded(weather)
        } catch {
            weatherLoadingStates[city] = .failed(error)
            weatherLoadingStates[city] = .idle
        }
    }
}

