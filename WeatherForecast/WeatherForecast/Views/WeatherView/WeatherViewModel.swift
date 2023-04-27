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
    @Published var isShowingCityListView = false
    @Published var cityNameText: String = "Dubai"

    var dateText: String {
        let date = Date()
        return DateFormatter.todayFormatter.string(from: date)
    }
    
    let currentWeatherViewModel: CurrentWeatherViewModel
    let dailyWeatherViewModel: DailyWeatherViewModel
    let cityStore: CityStore
    
    private let weatherService: WeatherService
    private var disposeBag = Set<AnyCancellable>()
    
    init(weatherService: WeatherService = .shared, cityStore: CityStore = .shared) {
        self.weatherService = weatherService
        self.cityStore = cityStore
        
        currentWeatherViewModel = CurrentWeatherViewModel(weatherService: weatherService)
        dailyWeatherViewModel = DailyWeatherViewModel(weatherService: weatherService)
        
        setupSubscriptions()
    }
    
    func fetchWeather(city: City? = nil) {
        Task {
            let city = city ?? cityStore.cities[0]
            try? await weatherService.getWeather(city: city)
        }
    }
    
    func showCityListView() {
        isShowingCityListView = true
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

        cityStore.$selectedCity
            .sink { [unowned self] city in
                guard let city else { return }
                cityNameText = city.name ?? ""
                fetchWeather(city: city)
            }
            .store(in: &disposeBag)
    }
}
