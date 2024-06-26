//
//  NewCityView.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 23/04/2023.
//

import SwiftUI

struct NewCityView : View {

    @StateObject private var viewModel = NewCityViewModel()
    @Environment(\.presentationMode) private var presentationMode
    @State private var cityName = ""

    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Search City", text: $cityName) {
                        self.viewModel.search(self.cityName)
                    }
                }
                
                Section {
                    ForEach(viewModel.predictions) { prediction in
                        Button(action: {
                            viewModel.addCity(from: prediction)
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Text(prediction.description)
                                .foregroundColor(.primary)
                        }
                    }
                }
            }
            .background {
                WeatherBackgroundView()
            }
            .scrollContentBackground(.hidden)
            .disabled(viewModel.isValidating)
            .navigationBarTitle(Text("Add City"))
            .navigationBarItems(leading: cancelButton)
            .listStyle(GroupedListStyle())
        }
    }
    
    private var cancelButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Text("Cancel")
        }
    }
}

struct NewCityView_Previews: PreviewProvider {
    static var previews: some View {
        NewCityView()
    }
}
