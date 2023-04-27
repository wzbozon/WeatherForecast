//
//  WeatherView.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 05.03.2023.
//

import SwiftUI

struct WeatherView: View {
    @StateObject private var viewModel = WeatherViewModel()

    var body: some View {
        ZStack(alignment: .top) {
            WeatherBackgroundView()

            VStack {
                WeatherHeaderView(
                    cityNameText: viewModel.cityNameText,
                    dateText: viewModel.dateText
                )
                .unredacted()

                Spacer()

                CurrentWeatherView()

                Spacer()

                DailyWeatherView()

                Spacer()

                WeatherFooterView(onButtonTap: {
                    viewModel.showCityListView()
                })
                .unredacted()
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
        .fullScreenCover(isPresented: $viewModel.isShowingCityListView) {
            CityListView()
        }
    }

    var cityListButton: some View {
        Button {
            viewModel.showCityListView()
        } label: {
            Text("Cities")
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
