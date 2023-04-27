//
//  WeatherViewModel.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 18/04/2023.
//

import Combine
import Foundation

@MainActor
final class WeatherViewModel: ObservableObject {
    var cityNameText: String = "Dubai"
    var dateText: String = "Tuesday, April 18"
}
