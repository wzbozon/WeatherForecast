//
//  DailyWeatherView.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 23/04/2023.
//

import SwiftUI

struct DailyWeatherView: View {
    @ObservedObject private var viewModel: DailyWeatherViewModel

    init(weather: Binding<Weather?>) {
        viewModel = DailyWeatherViewModel(weather: weather)
    }

    var body: some View {
        VStack {
            HStack {
                Text("5-Day Forecast")

                Spacer()
            }
            .foregroundColor(.gray)

            Divider()
                .overlay(Color.gray)

            ForEach(viewModel.dayWeatherList, id: \.self) { dayWeather in
                ZStack {
                    HStack {
                        Text(dayWeather.day)
                            .frame(width: Constants.textWidth, alignment: .leading)

                        Image(systemName: dayWeather.icon)

                        Spacer()

                        Text(dayWeather.temperatureHigh).padding(Padding.small)

                        Text(dayWeather.temperatureLow)
                    }
                    .foregroundColor(.white)
                }
            }
        }
        .padding(.horizontal)
    }

    private enum Constants {
        static let textWidth: CGFloat = 150
    }
}

struct DailyWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        DailyWeatherView(weather: .constant(nil))
    }
}
