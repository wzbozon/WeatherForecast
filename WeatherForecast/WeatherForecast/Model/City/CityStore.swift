//
//  CityStore.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 23/04/2023.
//

import Combine
import SwiftUI

class CityStore: ObservableObject {
    @Published var cities: [City] = [City()]
    @Published var selectedCity: City?

    func saveSelectedCity(_ city: City) {
        selectedCity = city
        UserDefaults.selectedCityID = city.id
    }
}
