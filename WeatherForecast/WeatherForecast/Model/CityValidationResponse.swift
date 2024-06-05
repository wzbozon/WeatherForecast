//
//  CityValidationResponse.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 23/04/2023.
//

import Foundation

struct CityValidationResponse: Codable {
    var cityData: CityData

    enum CodingKeys: String, CodingKey {
        case cityData = "result"
    }
}

struct CityData: Codable {
    var name: String
    var geometry: Geometry

    struct Geometry: Codable {
        var location: Location

        struct Location: Codable {
            var longitude: Double
            var latitude: Double

            enum CodingKeys: String, CodingKey {
                case longitude = "lng"
                case latitude = "lat"
            }
        }
    }
}
