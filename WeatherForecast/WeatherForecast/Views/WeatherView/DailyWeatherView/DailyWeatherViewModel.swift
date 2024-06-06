//
//  DailyWeatherViewModel.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 23/04/2023.
//

import Combine
import Foundation
import SwiftUI

@MainActor
final class DailyWeatherViewModel: ObservableObject {

    @Published var isLoading = false
    @Published var isShowingError = false
    @Published var errorMessage: String?
    @Published var dayWeatherList: [DayWeather] = []
    @Published private var weather: Weather?

    private var disposeBag = Set<AnyCancellable>()

    init(weather: Binding<Weather?>) {
        self.weather = weather.wrappedValue

        setupSubscriptions()

        if let weather = self.weather {
            update(with: weather)
        } else {
            dayWeatherList = []
            for _ in 0 ..< 6 {
                let dayWeather = DayWeather(
                    day: "------",
                    temperatureHigh: "---",
                    temperatureLow: "---",
                    icon: "sun.max"
                )

                dayWeatherList.append(dayWeather)
            }
        }
    }
}

// MARK: - Private

private extension DailyWeatherViewModel {
    func setupSubscriptions() {
        $weather
            .sink { [unowned self] weather in
                if let weather = weather {
                    update(with: weather)
                }
            }
            .store(in: &disposeBag)
    }

    func update(with weather: Weather) {
        let daily = weather.daily

        var temp: [DayWeather] = []

        for index in 0 ..< weather.daily.time.count {
            var day = daily.time[index]

            if let date = DateFormatter.serverFormatter.date(from: daily.time[index]) {
                day = DateFormatter.dailyWeatherFormatter.string(from: date)
            }

            let roundedHighTemperature = Int(daily.temperature2MMax[index])
            let formattedTemperatureHigh = "\(roundedHighTemperature)º"

            let roundedLowTemperature = Int(daily.temperature2MMin[index])
            let formattedTemperatureLow = "\(roundedLowTemperature)º"

            let dayWeather = DayWeather(
                day: day,
                temperatureHigh: formattedTemperatureHigh,
                temperatureLow: formattedTemperatureLow,
                icon: daily.weatherCode(at:index).icon
            )
            temp.append(dayWeather)
        }

        dayWeatherList = temp
    }
}
