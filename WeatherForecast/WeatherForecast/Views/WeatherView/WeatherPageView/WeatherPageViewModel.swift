//
//  WeatherPageViewModel.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 18/04/2023.
//

import Combine
import Foundation

@MainActor
final class WeatherPageViewModel: ObservableObject {
    @Published var isLoading = true
    @Published var isShowingError = false
    @Published var errorMessage: String?
    @Published var weather: Weather?
    private(set) var cityNameText: String = "Dubai"

    var dateText: String {
        let date = Date()
        return DateFormatter.todayFormatter.string(from: date)
    }

    init(city: City, weatherService: WeatherService = .shared, cityStore: CityStore = .shared) {
        self.city = city
        self.weatherService = weatherService
        self.cityStore = cityStore
        self.cityNameText = city.name ?? ""

        setupSubscriptions()
    }
    
    func fetchWeather() {
        Task {
            try? await weatherService.getWeather(city: city)
        }
    }
    
    private var disposeBag = Set<AnyCancellable>()
    private let city: City
    private let cityStore: CityStore
    private let weatherService: WeatherService
}

// MARK: - Private

private extension WeatherPageViewModel {
    func setupSubscriptions() {
        weatherService.$weatherLoadingStates
            .map { [unowned self] states in states[city] }
            .sink { [unowned self] state in
                switch state {
                case .loaded(let weather):
                    self.weather = weather
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

        weatherService.$weatherLoadingStates
            .map { [unowned self] states in states[city] }
            .map { state in
                if case .loading = state { return true }
                return false
            }
            .assign(to: \.isLoading, on: self)
            .store(in: &disposeBag)
    }
}
