//
//  CityRow.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 23/04/2023.
//

import SwiftUI

struct CityRow : View {
    @ObservedObject var city: City

    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(city.name ?? "")
                .lineLimit(nil)
                .font(.title)
                .fontWeight(.light)
                .foregroundColor(.white)
            Spacer()
        }
        .listRowBackground(Color.white.opacity(0.08))
        .padding([.trailing, .top, .bottom])
        .contentShape(Rectangle())
    }
}

struct CityRow_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext

        let newCity = City(context: viewContext)
        newCity.id = UUID()
        newCity.timestamp = Date()
        newCity.name = "Dubai"
        newCity.longitude = 55.14
        newCity.latitude = 25.09

        return CityRow(city: newCity)
    }
}
