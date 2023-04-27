//
//  CurrentWeatherViewModel.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 23/04/2023.
//

import Combine
import Foundation

@MainActor
final class CurrentWeatherViewModel: ObservableObject {
    @Published var weather: Weather?
    @Published var time: String = "--"
    @Published var summary: String = "Data Unavailable"
    @Published var icon: String = "sun.max"
    @Published var temperature: String = "--"
    @Published var windSpeed: String = "--"

    private let weatherService: WeatherService
    private var disposeBag = Set<AnyCancellable>()

    init(weatherService: WeatherService) {
        self.weatherService = weatherService

        setupSubscriptions()
    }
}

// MARK: - Private

private extension CurrentWeatherViewModel {
    func setupSubscriptions() {
        weatherService.$weatherLoadingState
            .sink { [unowned self] state in
                switch state {
                case .loaded(let weather):
                    self.weather = weather
                default:
                    break
                }
            }
            .store(in: &disposeBag)

        $weather
            .sink { [unowned self] weather in
                if let weather = weather {
                    didFetchWeather(weather)
                }
            }
            .store(in: &disposeBag)
    }

    func didFetchWeather(_ weather: Weather) {
        self.time = weather.currentWeather.time

        self.summary = weather.currentWeather.weatherCode.description

        self.icon = weather.currentWeather.weatherCode.icon

        let roundedTemperature = Int(weather.currentWeather.temperature)
        self.temperature = "\(roundedTemperature)º"

        let roundedWindSpeed = Int(weather.currentWeather.windspeed)
        self.windSpeed = "\(roundedWindSpeed) m/s"
    }
}
