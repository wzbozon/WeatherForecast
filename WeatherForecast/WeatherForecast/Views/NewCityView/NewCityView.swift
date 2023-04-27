//
//  NewCityView.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 23/04/2023.
//

import SwiftUI

struct NewCityView : View {
    @ObservedObject var viewModel = NewCityViewModel()
    @Binding private var isPresented: Bool

    @State private var search: String = ""
    @ObservedObject private var completer: CityCompletion = CityCompletion()
    
    @Environment(\.presentationMode) var presentationMode

    init(isPresented: Binding<Bool>) {
        _isPresented = isPresented
    }

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
                            self.viewModel.addCity(from: prediction)
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Text(prediction.description)
                                .foregroundColor(.primary)
                        }
                    }
                }
            }
            .disabled(viewModel.isValidating)
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
}

struct NewCityView_Previews: PreviewProvider {
    static var previews: some View {
        NewCityView(isPresented: .constant(true))
    }
}
