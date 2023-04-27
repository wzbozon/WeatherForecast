//
//  WeatherServiceEndpoint.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 22/04/2023.
//

import Foundation

enum WeatherServiceEndpoint: Endpoint {
    case getForecast

    var path: String {
        switch self {
        case .getForecast:
            return API.getForecast
        }
    }

    var requestType: RequestType {
        switch self {
        case .getForecast:
            return .get
        }
    }

    var parameters: [String: Any]? {
        switch self {
        case .getForecast:
            return [
                "latitude": 25.09,
                "longitude": 55.14,
                "hourly": "temperature_2m,relativehumidity_2m,apparent_temperature",
                "daily": "weathercode,temperature_2m_max,temperature_2m_min,apparent_temperature_max,apparent_temperature_min,sunrise,sunset,uv_index_max,uv_index_clear_sky_max",
                "current_weather": true,
                "windspeed_unit": "ms",
                "timezone": "auto",
                "start_date": "2023-02-26",
                "end_date": "2023-03-04"
            ]
        }
    }
}
