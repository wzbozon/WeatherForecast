//
//  WeatherPageViewModel.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 18/04/2023.
//

import Combine
import Factory
import Foundation

@MainActor
final class WeatherPageViewModel: ObservableObject {

    @Published var isLoading = true
    @Published var isShowingError = false
    @Published var errorMessage: String?
    @Published var weather: Weather?

    @Injected(\.cityRepository) private var cityRepository
    @Injected(\.weatherRepository) private var weatherRepository

    private(set) var cityNameText: String = "Dubai"

    var dateText: String {
        let date = Date()
        return DateFormatter.todayFormatter.string(from: date)
    }

    init(city: City) {
        self.city = city
        self.cityNameText = city.name ?? ""

        setupSubscriptions()
    }
    
    func fetchWeather() {
        Task {
            try? await weatherRepository.getWeather(city: city)
        }
    }
    
    private var disposeBag = Set<AnyCancellable>()
    private let city: City
}

// MARK: - Private

private extension WeatherPageViewModel {
    func setupSubscriptions() {
        weatherRepository.$weatherLoadingStates
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

        weatherRepository.$weatherLoadingStates
            .map { [unowned self] states in states[city] }
            .map { state in
                if case .loading = state { return true }
                return false
            }
            .assign(to: \.isLoading, on: self)
            .store(in: &disposeBag)
    }
}
