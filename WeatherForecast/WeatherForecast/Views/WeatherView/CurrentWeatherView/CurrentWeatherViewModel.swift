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
    @Published var time: String = "--"
    @Published var summary: String = "Data Unavailable"
    @Published var icon: String = "sun.max"
    @Published var temperature: String = "--"
    @Published var windSpeed: String = "--"
    @Published var humidity: String = "--"
    @Published var apparentTemperature: String = "--"
    @Published private var weather: Weather?

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
                    update(with: weather)
                }
            }
            .store(in: &disposeBag)
    }

    func update(with weather: Weather) {
        time = weather.currentWeather.time
        summary = weather.currentWeather.weatherCode.description
        icon = weather.currentWeather.weatherCode.icon

        let roundedTemperature = Int(weather.currentWeather.temperature)
        temperature = "\(roundedTemperature)º"

        let roundedWindSpeed = Int(weather.currentWeather.windspeed)
        windSpeed = "\(roundedWindSpeed) m/s"

        let date = Date()
        let dateString = DateFormatter.hourlyWeatherFormatter.string(from: date)
        let index = weather.hourly.time.firstIndex(of: dateString) ?? 0
        humidity = "\(weather.hourly.relativehumidity2M[index]) %"

        let roundedApparentTemperature = Int(weather.hourly.apparentTemperature[index])
        apparentTemperature = "\(roundedApparentTemperature)º"
    }
}
