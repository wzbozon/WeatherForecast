//
//  CityRepository.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 23/04/2023.
//

import Foundation
import CoreData
import OSLog

class CityRepository: ObservableObject {

    @Published var cities: [City] = []
    @Published var selectedCity: City?

    init() {
        Logger.default.info("[CityRepository] init")

        fetchCities()
    }

    deinit {
        Logger.default.info("[CityRepository] deinit")
    }

    func fetchCities() {
        let request = NSFetchRequest<City>(entityName: "City")
        do {
            cities = try viewContext.fetch(request)
            if cities.isEmpty {
                try addDefaultCity()
            }
        } catch {
            print("DEBUG: Some error occured while fetching")
        }
    }

    func addCity(name: String, longitude: Double, latitude: Double) {
        let city = City(context: viewContext)
        city.id = UUID()
        city.timestamp = Date()
        city.name = name
        city.longitude = longitude
        city.latitude = latitude

        save()
        fetchCities()
    }

    func addCity(cityData: CityData) {
        let city = City(context: viewContext)
        city.id = UUID()
        city.timestamp = Date()
        city.name = cityData.name
        city.longitude = cityData.geometry.location.longitude
        city.latitude = cityData.geometry.location.latitude

        save()
        fetchCities()
    }

    func deleteCity(_ city: City) {
        viewContext.delete(city)

        fetchCities()
    }

    func save() {
        do {
            try viewContext.save()
        } catch {
            print("Error saving")
        }
    }

    func selectCity(_ city: City) {
        selectedCity = city
        UserDefaults.selectedCityID = city.id?.uuidString
    }

    private let viewContext = PersistenceController.shared.viewContext
}

// MARK: - Private

private extension CityRepository {
    func addDefaultCity() throws {
        addCity(name: "Dubai", longitude: 55.14, latitude: 25.09)
    }
}
