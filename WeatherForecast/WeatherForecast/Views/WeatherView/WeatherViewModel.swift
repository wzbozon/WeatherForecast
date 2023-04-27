//
//  WeatherViewModel.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 18/04/2023.
//

import Combine
import Foundation

@MainActor
final class WeatherViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var isShowingError = false
    @Published var errorMessage: String?

    var cityNameText: String = "Dubai"
    
    var dateText: String {
        let date = Date()
        return DateFormatter.todayFormatter.string(from: date)
    }

    let currentWeatherViewModel: CurrentWeatherViewModel
    let dailyWeatherViewModel: DailyWeatherViewModel

    private let weatherService: WeatherService
    private var disposeBag = Set<AnyCancellable>()

    init(weatherService: WeatherService) {
        self.weatherService = weatherService

        currentWeatherViewModel = CurrentWeatherViewModel(weatherService: weatherService)
        dailyWeatherViewModel = DailyWeatherViewModel(weatherService: weatherService)
        
        setupSubscriptions()
    }

    func fetchWeather() {
        Task {
            try? await weatherService.getWeather()
        }
    }
}

// MARK: - Private

private extension WeatherViewModel {
    func setupSubscriptions() {
        weatherService.$weatherLoadingState
            .sink { [unowned self] state in
                switch state {
                case .failed(let error):
                    isShowingError = true
                    if let error = error as? RequestError {
                        errorMessage = error.message
                    } else {
                        errorMessage = "Unhandled error"
                    }
                default:
                    break
                }
            }
            .store(in: &disposeBag)

        weatherService.$weatherLoadingState
            .map { state in
                if case .loading = state { return true }
                return false
            }
            .assign(to: \.isLoading, on: self)
            .store(in: &disposeBag)
    }
}
