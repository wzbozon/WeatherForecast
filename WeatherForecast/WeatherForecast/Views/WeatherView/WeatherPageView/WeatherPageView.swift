//
//  WeatherPageView.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 27/04/2023.
//

import SwiftUI

struct WeatherPageView: View {
    @ObservedObject private var viewModel: WeatherPageViewModel

    init(city: City) {
        viewModel = WeatherPageViewModel(city: city)
    }

    var body: some View {
        VStack {
            WeatherHeaderView(
                cityNameText: viewModel.cityNameText,
                dateText: viewModel.dateText
            )
            .unredacted()
            
            Spacer()
            
            CurrentWeatherView(weather: $viewModel.weather)
            
            Spacer()
            
            DailyWeatherView(weather: $viewModel.weather)
            
            Spacer()
        }
        .redacted(reason: viewModel.isLoading ? .placeholder : [])
        .onAppear {
            viewModel.fetchWeather()
        }
        .errorPopup(
            isPresented: $viewModel.isShowingError,
            errorMessage: viewModel.errorMessage,
            onCancel: nil,
            onAction: {
                viewModel.fetchWeather()
            }
        )
    }
}

struct WeatherPageView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
