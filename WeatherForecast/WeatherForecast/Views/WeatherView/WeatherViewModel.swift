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

    let time: String
    let summary: String
    let icon: String
    let precipProbability: String
    let temperature: String
    let apparentTemperatureMax: String
    let apparentTemperatureMin: String
    let humidity: String
    let windSpeed: String

    init() {
        self.time = "--"
        self.summary = "Data Unavailable"
        self.icon = "default"
        self.precipProbability = "--"
        self.temperature = "--"
        self.apparentTemperatureMax = "--"
        self.apparentTemperatureMin = "--"
        self.humidity = "--"
        self.windSpeed = "--"
    }

    init(weather: Weather) {
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
