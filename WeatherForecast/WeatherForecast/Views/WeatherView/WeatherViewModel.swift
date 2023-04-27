//
//  WeatherViewModel.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 18/04/2023.
//

import Combine
import Foundation

@MainActor
final class WeatherViewModel: ObservableObject {
    var cityNameText: String = "Dubai"
    var dateText: String = "Tuesday, April 18"

    @Published var isLoading = false
    @Published var isShowingError = false
    @Published var errorMessage: String?
    @Published var weather: Weather?
    @Published var time: String = "--"
    @Published var summary: String = "Data Unavailable"
    @Published var icon: String = "default"
    @Published var precipProbability: String = "--"
    @Published var temperature: String = "--"
    @Published var apparentTemperatureMax: String = "--"
    @Published var apparentTemperatureMin: String = "--"
    @Published var humidity: String = "--"
    @Published var windSpeed: String = "--"

    private let weatherService: WeatherService
    private var disposeBag = Set<AnyCancellable>()

    init(weatherService: WeatherService) {
        self.weatherService = weatherService

        setupSubscriptions()
    }

    func fetchWeather() {
        Task {
            try? await weatherService.getWeather()
        }
    }
}

// MARK: - Private

private extension WeatherViewModel {
    func setupSubscriptions() {
        weatherService.$weatherLoadingState
            .sink { [unowned self] state in
                switch state {
                case .loaded(let weather):
                    self.weather = weather
                case .failed(let error):
                    isShowingError = true
                    if let error = error as? RequestError {
                        errorMessage = error.message
                    } else {
                        errorMessage = NSLocalizedString("error.unhandled", comment: "")
                    }
                default:
                    break
                }
            }
            .store(in: &disposeBag)

        weatherService.$weatherLoadingState
            .map { state in
                if case .loading = state { return true }
                return false
            }
            .assign(to: \.isLoading, on: self)
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

        self.summary = weather.daily.weathercode[0] == 0 ? "Sunny" : "Rainy"

        self.icon = "sun.max.fill"

        let precipPercentValue = 0
        self.precipProbability = "\(precipPercentValue)%"

        let roundedTemperature = Int(weather.currentWeather.temperature)
        self.temperature = "\(roundedTemperature)º"

        let apparentTemperatureMax = Int(weather.daily.apparentTemperatureMax[0])
        self.apparentTemperatureMax = "\(apparentTemperatureMax)º"
        let apparentTemperatureMin = Int(weather.daily.apparentTemperatureMin[0])
        self.apparentTemperatureMin = "\(apparentTemperatureMin)º"

        let humidityPercentValue = 0
        self.humidity = "\(humidityPercentValue)%"

        let roundedWindSpeed = Int(weather.currentWeather.windspeed)
        self.windSpeed = "\(roundedWindSpeed) mph"
    }
}
