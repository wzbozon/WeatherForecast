//
//  WeatherForecastApp.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 26/02/2023.
//

import SwiftUI

@main
struct WeatherForecastApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            CityView()
        }
    }
}
