//
//  WeatherService.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 22/04/2023.
//

import Foundation
import OSLog

protocol WeatherService {
    func getWeather(city: City) async throws -> Weather
}

actor DefaultWeatherService: WeatherService {
    func getWeather(city: City) async throws -> Weather {
        if let weather = cache[city] {
            return weather
        }

        let (data, response) = try await APIManager.shared.sendRequest(
            endpoint: WeatherServiceEndpoint.getForecast(city: city)
        )

        let decoder = JSONDecoder()

        if let response = response as? HTTPURLResponse,
           response.statusCode != Constants.positiveResponseCode {
            throw RequestError.networkError
        }

        do {
            let weather = try decoder.decode(Weather.self, from: data)
            cache[city] = weather
            return weather
        } catch let error as DecodingError {
            Logger.default.info("[DefaultWeatherService] Decoding error: \(error.message, privacy: .public)")
            throw error
        } catch {
            Logger.default.info("[DefaultWeatherService] Error: \(error, privacy: .public)")
            throw error
        }
    }

    private enum Constants {
        static let positiveResponseCode = 200
    }

    private var cache: [City: Weather] = [:]
}
