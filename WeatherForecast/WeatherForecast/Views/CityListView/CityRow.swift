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
            Text(city.name)
                .lineLimit(nil)
                .font(.title)
        }
        .padding([.trailing, .top, .bottom])
    }
}

struct CityRow_Previews: PreviewProvider {
    static var previews: some View {
        CityRow(
            city: City(
                cityData: CityValidation.CityData(
                    name: "Dubai",
                    geometry: CityValidation.CityData.Geometry(
                        location: CityValidation.CityData.Geometry.Location(longitude: 55.14, latitude: 25.09)
                    )
                )
            )
        )
    }
}
