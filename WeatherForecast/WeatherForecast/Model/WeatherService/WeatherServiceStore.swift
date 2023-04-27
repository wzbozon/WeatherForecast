//
//  WeatherServiceStore.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 22/04/2023.
//

import Foundation
import OSLog

protocol WeatherServiceStoreProtocol {
    func getWeather() async throws -> Weather
}

actor WeatherServiceStore: WeatherServiceStoreProtocol {
    func getWeather() async throws -> Weather {
        let (data, response) = try await APIManager.shared.sendRequest(
            endpoint: WeatherServiceEndpoint.getForecast
        )

        let decoder = JSONDecoder()

        if let response = response as? HTTPURLResponse,
           response.statusCode != Constants.positiveResponseCode {
            throw RequestError.statusNotOk
        }

        do {
            let weather = try decoder.decode(Weather.self, from: data)
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
}
