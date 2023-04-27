//
//  DailyWeatherView.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 23/04/2023.
//

import SwiftUI

struct DailyWeatherView: View {
    @StateObject private var viewModel: DailyWeatherViewModel

    init(viewModel: DailyWeatherViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack {
            HStack {
                Text("5-Day Forecast")

                Spacer()
            }
            .padding(.leading)
            .foregroundColor(.gray)

            Divider()
                .padding([.leading, .trailing])

            ForEach(viewModel.dayWeatherList, id: \.self) { dayWeather in
                ZStack {
                    HStack {
                        Text(dayWeather.day)
                        Spacer()
                        Text(dayWeather.temperatureHigh).padding(8)
                        Text(dayWeather.temperatureLow)
                    }
                    .padding([.leading, .trailing])
                    .foregroundColor(.white)

                    Image(systemName: dayWeather.icon)
                        .foregroundColor(.white)
                }
            }
        }
    }
}

struct DailyWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        DailyWeatherView(viewModel: DailyWeatherViewModel(weatherService: .init()))
    }
}
