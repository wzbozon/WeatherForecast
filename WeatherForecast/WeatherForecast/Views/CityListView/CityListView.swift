//
//  CityListView.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 23/04/2023.
//

import SwiftUI

struct CityListView : View {
    @EnvironmentObject var cityStore: CityStore
    @Environment(\.presentationMode) var presentationMode
    @State var isPresentingModal: Bool = false
    @State private var isEditing: Bool = false

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Your Cities")) {
                    ForEach(cityStore.cities, id: \.name) { city in
                        CityRow(city: city)
                            .onTapGesture {
                                selectCity(city)
                            }
                    }
                    .onDelete(perform: delete)
                    .onMove(perform: move)
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
            NewCityView().environmentObject(self.cityStore)
        }
    }

    private func delete(at offsets: IndexSet) {
        for index in offsets {
            cityStore.cities.remove(at: index)
        }
    }

    private func move(from source: IndexSet, to destination: Int) {
        var removeCities: [City] = []

        for index in source {
            removeCities.append(cityStore.cities[index])
            cityStore.cities.remove(at: index)
        }

        cityStore.cities.insert(contentsOf: removeCities, at: destination)
    }

    private func selectCity(_ city: City) {
        // TODO: save selected city
        presentationMode.wrappedValue.dismiss()
    }
}

struct CityListView_Previews: PreviewProvider {
    static var previews: some View {
        CityListView()
    }
}
