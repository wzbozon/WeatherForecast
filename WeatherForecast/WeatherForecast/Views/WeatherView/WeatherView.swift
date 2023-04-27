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

                WeatherCurrentView()

                Spacer()

                WeatherFooterView()
            }
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(viewModel: WeatherViewModel())
    }
}
