//
//  CurrentWeatherView.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 18/04/2023.
//

import SwiftUI

struct CurrentWeatherView: View {
    @ObservedObject private var viewModel: CurrentWeatherViewModel
    
    init(weather: Binding<Weather?>) {
        viewModel = CurrentWeatherViewModel(weather: weather)
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: Spacing.big) {
                Image(systemName: viewModel.icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)

                Text(viewModel.summary)
                    .font(.title)
                    .fontWeight(.light)
            }

            HStack {
                Text(viewModel.temperature)
                    .font(.system(size: 100))
                    .fontWeight(.ultraLight)
                    .fixedText()

                Spacer()

                VStack(alignment: .leading, spacing: Spacing.small) {
                    HStack {
                        Text("WIND SPEED")
                        Text(viewModel.windSpeed)
                    }

                    HStack {
                        Text("HUMIDITY")
                        Text(viewModel.humidity)
                    }

                    HStack {
                        Text("APPARENT TEMP")
                        Text(viewModel.apparentTemperature)
                    }
                }
                .font(.caption)
            }
        }
        .foregroundColor(.white)
        .padding(.horizontal)
    }
}

struct CurrentWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            WeatherBackgroundView()

            CurrentWeatherView(weather: .constant(nil))
        }
    }
}
