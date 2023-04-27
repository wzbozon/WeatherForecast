//
//  CityCompletion.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 23/04/2023.
//

import Combine
import SwiftUI

class CityCompletion: NSObject, ObservableObject {
    @Published var predictions: [CityCompletion.Prediction] = []

    private var completionManager: CityCompletionManager
    
    override init() {
        predictions = []
        completionManager = CityCompletionManager()
        super.init()
    }
    
    func search(_ search: String) {
        completionManager.getCompletion(for: search) { (predictions) in
            DispatchQueue.main.async {
                self.predictions = predictions
            }
        }
    }
}
