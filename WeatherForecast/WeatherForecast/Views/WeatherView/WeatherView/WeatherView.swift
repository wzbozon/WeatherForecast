//
//  WeatherView.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 05.03.2023.
//

import SwiftUI

struct WeatherView: View {

    @StateObject private var viewModel = WeatherViewModel()

    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font : UIFont(name:"Helvetica Neue Light", size: 32)!
        ]
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            WeatherBackgroundView()

            tabView

            VStack {
                Spacer()

                HStack {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Powered by")
                                .foregroundColor(.white)
                                .font(.footnote)

                            Text("Open-Meteo")
                                .foregroundColor(.white)
                                .font(.footnote)
                                .fontWeight(.bold)
                        }
                        .padding(.leading)

                        Spacer()
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)

                    controlBar
                        .frame(minWidth: 0, maxWidth: .infinity)

                    HStack {
                        Spacer()

                        Button {
                            viewModel.showCityListView()
                        } label: {
                            Image(systemName: "list.bullet")
                                .foregroundColor(.white)
                        }
                        .padding(.trailing)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                }
            }
        }
        .fullScreenCover(isPresented: $viewModel.isShowingCityListView) {
            CityListView()
        }
    }

    @ViewBuilder
    private var tabView: some View {
        TabView(selection: $viewModel.page) {
            ForEach(viewModel.cities.indices, id: \.self) { i in
                WeatherPageView(city: viewModel.cities[i])
                    .tag(i)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
    }

    @ViewBuilder
    private var controlBar: some View {
        HStack {
            Spacer()

            PageControl(
                currentPage: $viewModel.page,
                numberOfPages: viewModel.cities.count
            )

            Spacer()
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
