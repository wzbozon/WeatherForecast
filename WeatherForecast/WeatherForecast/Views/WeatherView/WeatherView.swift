//
//  WeatherView.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 05.03.2023.
//

import SwiftUI

struct WeatherView: View {
    @StateObject private var viewModel: WeatherViewModel

    init(viewModel: WeatherViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack(alignment: .top) {
            WeatherBackgroundView()

            VStack {
                WeatherHeaderView(
                    cityNameText: viewModel.cityNameText,
                    dateText: viewModel.dateText
                )

                Spacer()

                CurrentWeatherView(viewModel: viewModel.currentWeatherViewModel)

                Spacer()

                DailyWeatherView(viewModel: viewModel.dailyWeatherViewModel)

                Spacer()

                WeatherFooterView()
            }
            .redacted(reason: viewModel.isLoading ? .placeholder : [])
        }
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

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(viewModel: WeatherViewModel(weatherService: .init()))
    }
}
