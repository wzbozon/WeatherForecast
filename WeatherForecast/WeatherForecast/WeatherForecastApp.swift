//
//  WeatherForecastApp.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 26/02/2023.
//

import SwiftUI

@main
struct WeatherForecastApp: App {
    @StateObject private var model = Model()

    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            WeatherView(
                viewModel: WeatherViewModel(
                    weatherService: model.weatherService
                )
            )
            .environmentObject(model)
        }
    }
}
