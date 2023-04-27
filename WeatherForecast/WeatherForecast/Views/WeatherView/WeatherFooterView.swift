//
//  WeatherFooterView.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 18/04/2023.
//

import SwiftUI

struct WeatherFooterView: View {
    var body: some View {
        VStack {
            Text("Powered by")
                .foregroundColor(.white)
                .font(.footnote)

            Text("Open-Meteo")
                .foregroundColor(.white)
                .font(.footnote)
                .fontWeight(.bold)
        }
    }
}

struct WeatherFooterView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack(alignment: .bottom) {
            WeatherBackgroundView()

            WeatherFooterView()
        }
    }
}
