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
    static let shared = WeatherService()
    
    @Published var weatherLoadingStates: [City: LoadingState<Weather>] = [:]

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

