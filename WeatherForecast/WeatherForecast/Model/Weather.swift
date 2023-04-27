//
//  Weather.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 26/02/2023.
//
//  This file was generated from JSON Schema using quicktype, do not modify it directly.
//  To parse the JSON, add this file to your project and do:
//
//  let weather = try? JSONDecoder().decode(Weather.self, from: jsonData)
//
//  https://open-meteo.com
//  https://api.open-meteo.com/v1/forecast?latitude=25.09&longitude=55.14&hourly=temperature_2m,relativehumidity_2m,apparent_temperature&daily=weathercode,temperature_2m_max,temperature_2m_min,apparent_temperature_max,apparent_temperature_min,sunrise,sunset,uv_index_max,uv_index_clear_sky_max&current_weather=true&windspeed_unit=ms&timezone=auto&start_date=2023-02-26&end_date=2023-03-04
//
//  https://app.quicktype.io

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
