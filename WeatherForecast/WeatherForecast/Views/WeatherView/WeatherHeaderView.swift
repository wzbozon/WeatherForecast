//
//  WeatherHeaderView.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 18/04/2023.
//

import SwiftUI

struct WeatherHeaderView: View {
    let cityNameText: String
    let dateText: String

    var body: some View {
        VStack {
            Text(cityNameText)
                .foregroundColor(.white)
                .font(.title)
                .fontWeight(.light)

            Text(dateText)
                .foregroundColor(.gray)
        }
    }
}

struct WeatherHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack(alignment: .top) {
            WeatherBackgroundView()

            WeatherHeaderView(
                cityNameText: "Dubai",
                dateText: "Tuesday, April 18"
            )
        }
    }
}
