//
//  WeatherFooterView.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 18/04/2023.
//

import SwiftUI

struct WeatherFooterView: View {
    var onButtonTap: (() -> Void)?

    var body: some View {
        HStack {
            VStack {
                Text("Powered by")
                    .foregroundColor(.white)
                    .font(.footnote)

                Text("Open-Meteo")
                    .foregroundColor(.white)
                    .font(.footnote)
                    .fontWeight(.bold)
            }

            Spacer()

            Button {
                onButtonTap?()
            } label: {
                Image(systemName: "list.bullet")
                    .foregroundColor(.white)
            }
        }
        .padding(.horizontal)
    }
}

struct WeatherFooterView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack(alignment: .bottom) {
            WeatherBackgroundView()

            WeatherFooterView(onButtonTap: nil)
        }
    }
}
