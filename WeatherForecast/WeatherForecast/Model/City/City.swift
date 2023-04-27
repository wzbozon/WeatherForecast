//
//  City.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 23/04/2023.
//

import Combine
import SwiftUI

class City: ObservableObject {
    let name: String
    let longitude: Double
    let latitude: Double

    @Published var image: UIImage?
    @Published var weather: Weather?

    init() {
        name = "Dubai"
        longitude = 55.14
        latitude = 25.09
        image = nil
        weather = nil
    }

    init(cityData data: CityValidation.CityData) {
        name = data.name
        longitude = data.geometry.location.longitude
        latitude = data.geometry.location.latitude
        image = nil
        weather = nil
    }
}
