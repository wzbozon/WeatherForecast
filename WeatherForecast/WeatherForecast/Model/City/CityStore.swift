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
    @Published var cities: [City] = []
    @Published var selectedCity: City?

    init() {
        let viewContext = PersistenceController.shared.container.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "City")

        do {
            cities = try viewContext.fetch(request) as? [City] ?? []
            if cities.count == 0 {
                let newCity = City(context: viewContext)
                newCity.id = UUID()
                newCity.timestamp = Date()
                newCity.name = "Dubai"
                newCity.longitude = 55.14
                newCity.latitude = 25.09

                try viewContext.save()
                cities = [newCity]
            }
        } catch {
            print("Failed")
        }
    }

    func saveCity(_ city: City) {
        let viewContext = PersistenceController.shared.container.viewContext
        do {
            try viewContext.save()
            cities.append(city)
        } catch {
            print("Failed")
        }
    }

    func saveSelectedCity(_ city: City) {
        selectedCity = city
        UserDefaults.selectedCityID = city.id?.uuidString
    }

    let container = NSPersistentContainer(name: "CoreDataModel")
}
