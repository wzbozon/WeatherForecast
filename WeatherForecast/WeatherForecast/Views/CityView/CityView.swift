//
//  CityView.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 05.03.2023.
//

import SwiftUI

struct CityView: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [Color.appDarkBlue, Color.appBlue]),
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }
}

struct CityView_Previews: PreviewProvider {
    static var previews: some View {
        CityView()
    }
}
