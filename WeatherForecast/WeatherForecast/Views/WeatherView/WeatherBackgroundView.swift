//
//  WeatherBackgroundView.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 18/04/2023.
//

import SwiftUI

struct WeatherBackgroundView: View {

    var body: some View {
        LinearGradient(
            gradient: Gradient(
                colors: [
                    Color.black,
                    Color.gradient1,
                    Color.gradient2
                ]
            ),
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }
}

struct WeatherBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherBackgroundView()
    }
}
