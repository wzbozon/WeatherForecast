//
//  CityListView.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 23/04/2023.
//

import SwiftUI

struct CityListView : View {
    @ObservedObject var viewModel = CityListViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State var isPresentingModal: Bool = false
    @State private var isEditing: Bool = false

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Your Cities")) {
                    ForEach(viewModel.cities, id: \.name) { city in
                        CityRow(city: city)
                            .onTapGesture {
                                viewModel.selectCity(city)
                                self.presentationMode.wrappedValue.dismiss()
                            }
                    }
                    .onDelete(perform: viewModel.delete)
                    .onMove(perform: viewModel.move)
                }
            }
            .navigationBarItems(leading: EditButton(), trailing: addButton)
            .navigationBarTitle(Text("Weather"))
        }
    }

    private var addButton: some View {
        Button(action: {
            self.isPresentingModal = true
        }) {
            Image(systemName: "plus.circle.fill")
                .font(.title)
        }.sheet(isPresented: $isPresentingModal) {
            NewCityView(isPresented: $isPresentingModal)
        }
    }
}

struct CityListView_Previews: PreviewProvider {
    static var previews: some View {
        CityListView()
    }
}
