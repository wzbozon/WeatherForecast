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
    @StateObject private var cityStore = CityStore()

    var body: some Scene {
        WindowGroup {
            WeatherView(
                viewModel: WeatherViewModel(
                    weatherService: model.weatherService
                )
            )
            .environmentObject(model)
            .environment(\.managedObjectContext, cityStore.container.viewContext)
        }
    }
}
