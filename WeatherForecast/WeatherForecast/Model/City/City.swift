//
//  City.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 23/04/2023.
//

import Combine
import CoreData
import SwiftUI

class City: ObservableObject {
    var id: UUID
    var name: String
    var longitude: Double
    var latitude: Double

    @Published var image: UIImage?
    @Published var weather: Weather?

    init() {
        id = UUID()
        name = "Dubai"
        longitude = 55.14
        latitude = 25.09
        image = nil
        weather = nil
    }

    init(cityData data: CityValidation.CityData) {
        id = UUID()
        name = data.name
        longitude = data.geometry.location.longitude
        latitude = data.geometry.location.latitude
        image = nil
        weather = nil
    }
}
