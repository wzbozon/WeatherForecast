//
//  ServerEnvironment.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 22/04/2023.
//

import Foundation

enum ServerEnvironment: String, CaseIterable, Identifiable {

    case production

    static var current: ServerEnvironment {
        .production
    }

    var id: Self { self }

    var url: String {
        switch self {
        case .production:
            return "https://api.open-meteo.com/v1/"
        }
    }
}
