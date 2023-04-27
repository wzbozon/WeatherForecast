//
//  WeatherCurrentView.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 18/04/2023.
//

import SwiftUI

struct WeatherCurrentView: View {
    @StateObject private var viewModel: WeatherViewModel

    init(viewModel: WeatherViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(viewModel.icon)
                    .resizable()
                    .frame(width: 40, height: 40)

                Text(viewModel.summary)
                    .font(.title)
                    .fontWeight(.light)
                }.padding(0)

            HStack {
                Text(viewModel.temperature)
                    .font(.system(size: 150))
                    .fontWeight(.ultraLight)

                VStack(alignment: .leading) {
                    HStack {
                        Text("FEELS LIKE MAX")
                        Spacer()
                        Text(viewModel.apparentTemperatureMax)
                        }.padding(.bottom, 1)

                    HStack {
                        Text("FEELS LIKE MIN")
                        Spacer()
                        Text(viewModel.apparentTemperatureMin)
                        }.padding(.bottom, 1)

                    HStack {
                        Text("WIND SPEED")
                        Spacer()
                        Text(viewModel.windSpeed)
                        }.padding(.bottom, 1)

                    HStack {
                        Text("HUMIDITY")
                        Spacer()
                        Text(viewModel.humidity)
                        }.padding(.bottom, 1)

                    HStack {
                        Text("PRECIPITATION")
                        Spacer()
                        Text(viewModel.precipProbability)
                        }.padding(.bottom, 1)
                    }.font(.caption)
                }.padding(0)
        }
        .foregroundColor(.white)
        .padding(.horizontal)
    }
}

struct WeatherCurrentView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            WeatherBackgroundView()

            WeatherCurrentView(viewModel: WeatherViewModel(weatherService: .init()))
        }
    }
}
