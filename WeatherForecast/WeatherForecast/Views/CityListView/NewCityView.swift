//
//  NewCityView.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 23/04/2023.
//

import SwiftUI

struct NewCityView : View {
    @State private var search: String = ""
    @State private var isValidating: Bool = false
    @ObservedObject private var completer: CityCompletion = CityCompletion()
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var cityStore: CityStore
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Search City", text: $search) {
                        self.completer.search(self.search)
                    }
                }
                
                Section {
                    ForEach(completer.predictions) { prediction in
                        Button(action: {
                            self.addCity(from: prediction)
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Text(prediction.description)
                                .foregroundColor(.primary)
                        }
                    }
                }
            }
            .disabled(isValidating)
            .navigationBarTitle(Text("Add City"))
            .navigationBarItems(leading: cancelButton)
            .listStyle(GroupedListStyle())
        }
    }
    
    private var cancelButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Text("Cancel")
        }
    }
    
    private func addCity(from prediction: CityCompletion.Prediction) {
        isValidating = true
        
        CityValidation.validateCity(withID: prediction.id) { cityData in
            if let cityData {
                DispatchQueue.main.async {
                    let city = City.create(with: cityData)
                    self.cityStore.saveCity(city)
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
            
            DispatchQueue.main.async {
                self.isValidating = false
            }
        }
    }
}

struct NewCityView_Previews: PreviewProvider {
    static var previews: some View {
        NewCityView()
    }
}
