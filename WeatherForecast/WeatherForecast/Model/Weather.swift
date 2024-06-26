//
//  Weather.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 26/02/2023.
//
//  This file was generated from JSON Schema using quicktype, do not modify it directly.
//  To parse the JSON, add this file to your project and do:
//

import Foundation

// MARK: - Welcome

struct Weather: Codable {
    let latitude, longitude, generationtimeMS: Double
    let utcOffsetSeconds: Int
    let timezone, timezoneAbbreviation: String
    let elevation: Int
    let currentWeather: CurrentWeather
    let hourlyUnits: HourlyUnits
    let hourly: Hourly
    let dailyUnits: DailyUnits
    let daily: Daily

    enum CodingKeys: String, CodingKey {
        case latitude, longitude
        case generationtimeMS = "generationtime_ms"
        case utcOffsetSeconds = "utc_offset_seconds"
        case timezone
        case timezoneAbbreviation = "timezone_abbreviation"
        case elevation
        case currentWeather = "current_weather"
        case hourlyUnits = "hourly_units"
        case hourly
        case dailyUnits = "daily_units"
        case daily
    }
}

// MARK: - CurrentWeather

struct CurrentWeather: Codable {
    let temperature, windspeed: Double
    let winddirection, weathercode, isDay: Int
    let time: String

    var weatherCode: WeatherCode {
        WeatherCode(code: weathercode)
    }

    enum CodingKeys: String, CodingKey {
        case temperature, windspeed, winddirection, weathercode
        case isDay = "is_day"
        case time
    }
}

// MARK: - Daily

struct Daily: Codable {
    let time: [String]
    let weathercode: [Int]
    let temperature2MMax, temperature2MMin, apparentTemperatureMax, apparentTemperatureMin: [Double]
    let sunrise, sunset: [String]
    let uvIndexMax, uvIndexClearSkyMax: [Double]

    func weatherCode(at index: Int) -> WeatherCode {
        WeatherCode(code: weathercode[index])
    }

    enum CodingKeys: String, CodingKey {
        case time, weathercode
        case temperature2MMax = "temperature_2m_max"
        case temperature2MMin = "temperature_2m_min"
        case apparentTemperatureMax = "apparent_temperature_max"
        case apparentTemperatureMin = "apparent_temperature_min"
        case sunrise, sunset
        case uvIndexMax = "uv_index_max"
        case uvIndexClearSkyMax = "uv_index_clear_sky_max"
    }
}

// MARK: - Hashable

extension Daily: Hashable {
    static func == (lhs: Daily, rhs: Daily) -> Bool {
        lhs.time == rhs.time
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(time)
    }
}

// MARK: - DailyUnits

struct DailyUnits: Codable {
    let time, weathercode, temperature2MMax, temperature2MMin: String
    let apparentTemperatureMax, apparentTemperatureMin, sunrise, sunset: String
    let uvIndexMax, uvIndexClearSkyMax: String

    enum CodingKeys: String, CodingKey {
        case time, weathercode
        case temperature2MMax = "temperature_2m_max"
        case temperature2MMin = "temperature_2m_min"
        case apparentTemperatureMax = "apparent_temperature_max"
        case apparentTemperatureMin = "apparent_temperature_min"
        case sunrise, sunset
        case uvIndexMax = "uv_index_max"
        case uvIndexClearSkyMax = "uv_index_clear_sky_max"
    }
}

// MARK: - Hourly

struct Hourly: Codable {
    let time: [String]
    let temperature2M: [Double]
    let relativehumidity2M: [Int]
    let apparentTemperature: [Double]

    enum CodingKeys: String, CodingKey {
        case time
        case temperature2M = "temperature_2m"
        case relativehumidity2M = "relativehumidity_2m"
        case apparentTemperature = "apparent_temperature"
    }
}

// MARK: - HourlyUnits

struct HourlyUnits: Codable {
    let time, temperature2M, relativehumidity2M, apparentTemperature: String

    enum CodingKeys: String, CodingKey {
        case time
        case temperature2M = "temperature_2m"
        case relativehumidity2M = "relativehumidity_2m"
        case apparentTemperature = "apparent_temperature"
    }
}
