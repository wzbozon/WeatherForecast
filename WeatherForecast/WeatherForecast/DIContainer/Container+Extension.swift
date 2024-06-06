//
//  Container+Extension.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 06/06/2024.
//

import Factory
import Foundation
import UserNotifications

extension Container {
    var userDefaults: Factory<UserDefaults> {
        self { UserDefaults.standard }
    }

    var urlSession: Factory<URLSession> {
        self { URLSession.shared }
    }

    var decoder: Factory<JSONDecoder> {
        self { JSONDecoder() }
    }

    var apiManager: Factory<APIManager> {
        self { APIManager() }.singleton
    }

    var cityRepository: Factory<CityRepository> {
        self { CityRepository() }.singleton
    }

    var cityAutocompleteRepository: Factory<CityAutocompleteRepository> {
        self { CityAutocompleteRepository() }.singleton
    }

    var weatherRepository: Factory<WeatherRepository> {
        self { WeatherRepository() }.singleton
    }
}
