//
//  NetworkManager.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 23/04/2023.
//

import UIKit

class NetworkManager: NSObject {
    struct Key {
        static let googleMaps: String = "AIzaSyDKh5A4q4USR-a5iqeQs3uXfcaRHpo-LEI" // Enter your google maps API key here
    }

    struct APIURL {
        static func cityCompletion(for search: String) -> String {
            return "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=\(search)&types=(cities)&key=\(NetworkManager.Key.googleMaps)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        }

        static func cityData(for placeID: String) ->  String {
            return "https://maps.googleapis.com/maps/api/place/details/json?placeid=\(placeID)&key=\(NetworkManager.Key.googleMaps)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        }
    }
}
