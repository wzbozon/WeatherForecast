//
//  WeatherCode.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 23/04/2023.
//

import Foundation

struct WeatherCode {
    let code: Int

    var description: String {
        WeatherCode.map[code] ?? ""
    }

    var icon: String {
        switch code {
        case 0:
            return "sun.max"
        case 1, 2, 3:
            return "cloud"
        case 45, 48:
            return "cloud.fog"
        case 51, 53, 55, 56, 57, 61, 63, 65, 66, 67, 80, 81, 82:
            return "cloud.rain"
        case 71, 73, 75, 77, 85, 86:
            return "snowflake"
        case 95, 96, 99:
            return "tropicalstorm"
        default:
            return "questionmark"
        }
    }

    private static let map: [Int: String] = [
        0: "Clear sky",
        1: "Mainly clear",
        2: "Partly cloudy",
        3: "Overcast",
        45: "Fog",
        48: "Depositing rime fog",
        51: "Drizzle (light)",
        53: "Drizzle (moderate)",
        55: "Drizzle (dense)",
        56: "Freezing drizzle (light)",
        57: "Freezing drizzle (dense)",
        61: "Rain (light)",
        63: "Rain (moderate)",
        65: "Rain (heavy)",
        66: "Freezing rain (light)",
        67: "Freezing rain (heavy)",
        71: "Snow fall (slight)",
        73: "Snow fall (moderate)",
        75: "Snow fall (heavy)",
        77: "Snow grains ",
        80: "Rain shower (slight)",
        81: "Rain shower (moderate)",
        82: "Rain shower (violent)",
        85: "Snow shower (slight)",
        86: "Snow shower (heavy)",
        95: "Thunderstorm (moderate)",
        96: "Thunderstorm (with slight hail)",
        99: "Thunderstorm (with heavy hail)"
    ]
}
