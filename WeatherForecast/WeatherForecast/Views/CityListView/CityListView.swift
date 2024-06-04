//
//  CityListView.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 23/04/2023.
//

import SwiftUI

struct CityListView : View {
    @StateObject private var viewModel = CityListViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var isShowingNewCityView = false

    var body: some View {
        NavigationView {
            List {
                Section(
                    header: Text("Your Cities").foregroundColor(.white)
                ) {
                    ForEach(viewModel.cities, id: \.name) { city in
                        CityRow(city: city)
                            .onTapGesture {
                                print("Tapped cell")
                                viewModel.selectCity(city)
                                presentationMode.wrappedValue.dismiss()
                            }
                    }
                    .onDelete(perform: viewModel.delete)
                }
            }
            .background {
                WeatherBackgroundView()
            }
            .scrollContentBackground(.hidden)
            .navigationBarItems(leading: EditButton(), trailing: addButton)
            .navigationBarTitle(Text("Weather"))
        }
    }

    private var addButton: some View {
        Button(action: {
            self.isShowingNewCityView = true
        }) {
            Image(systemName: "plus.circle.fill")
                .font(.title)
        }.fullScreenCover(isPresented: $isShowingNewCityView) {
            NewCityView()
        }
    }
}

struct CityListView_Previews: PreviewProvider {
    static var previews: some View {
        CityListView()
    }
}
