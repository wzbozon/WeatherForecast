//
//  City.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 23/04/2023.
//

import Combine
import CoreData
import SwiftUI

extension City {
    static func create(with cityData: CityValidation.CityData) -> City {
        let viewContext = PersistenceController.shared.container.viewContext

        let newCity = City(context: viewContext)
        newCity.id = UUID()
        newCity.timestamp = Date()
        newCity.name = cityData.name
        newCity.longitude = cityData.geometry.location.longitude
        newCity.latitude = cityData.geometry.location.latitude

        return newCity
    }
}
