//
//  CityValidationService.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 23/04/2023.
//

import Foundation

protocol CityValidationService: AnyObject {
    static func validateCity(
        withID placeID: String,
        _ completion: @escaping (_ cityData: CityData?) -> Void
    )
}

class DefaultCityValidationService: CityValidationService {

    static func validateCity(withID placeID: String, _ completion: @escaping (_ cityData: CityData?) -> Void) {
        guard let url = URL(string: NetworkManager.APIURL.cityData(for: placeID)) else {
            completion(nil)
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.cachePolicy = .reloadIgnoringLocalCacheData
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = [
            "Content-Type": "application/json",
            "Accept": "*/*",
            "X-Ios-Bundle-Identifier": Bundle.main.bundleIdentifier ?? ""
        ]

        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data else {
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(CityValidationResponse.self, from: data)
                completion(result.cityData)
            } catch {
                print(error.localizedDescription)
                completion(nil)
            }
        }
        .resume()
    }
}

