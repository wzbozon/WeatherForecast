//
//  CityStore.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 23/04/2023.
//

import Combine
import CoreData
import SwiftUI

class CityStore: ObservableObject {
    @Published var cities: [City] = [City()]
    @Published var selectedCity: City?

    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }

    func saveSelectedCity(_ city: City) {
        selectedCity = city
        UserDefaults.selectedCityID = city.id.uuidString
    }

    let container = NSPersistentContainer(name: "Model")
}
