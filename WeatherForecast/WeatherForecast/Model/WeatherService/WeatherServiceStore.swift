//
//  WeatherServiceStore.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 22/04/2023.
//

import Foundation
import OSLog

protocol WeatherServiceStoreProtocol {
    func getWeather(city: City) async throws -> Weather
}

actor WeatherServiceStore: WeatherServiceStoreProtocol {
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
            throw RequestError.statusNotOk
        }

        do {
            let weather = try decoder.decode(Weather.self, from: data)
            cache[city] = weather
            return weather
        } catch let error as DecodingError {
            Logger.default.info("[WeatherServiceStore] Decoding error: \(error.message, privacy: .public)")
            throw error
        } catch {
            Logger.default.info("[WeatherServiceStore] Error: \(error, privacy: .public)")
            throw error
        }
    }

    private enum Constants {
        static let positiveResponseCode = 200
    }

    private var cache: [City: Weather] = [:]
}
