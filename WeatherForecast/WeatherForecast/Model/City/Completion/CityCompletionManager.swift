//
//  CityCompletionManager.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 23/04/2023.
//

import UIKit

class CityCompletionManager: NSObject {
    var completionTask: URLSessionDataTask?
    
    func getCompletion(
        for search: String,
        _ completion: @escaping (_ results: [CityCompletion.Prediction]) -> Void
    ) {
        guard let url = URL(string: NetworkManager.APIURL.cityCompletion(for: search)) else {
            completion([])
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

        completionTask?.cancel()
        
        completionTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data else {
                completion([])
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(CityCompletion.Result.self, from: data)
                completion(result.predictions)
            } catch {
                print(error.localizedDescription)
                completion([])
            }
        }
        
        completionTask?.resume()
    }
}
