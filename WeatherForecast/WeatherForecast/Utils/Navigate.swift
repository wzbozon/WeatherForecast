//
//  Navigate.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 23/04/2023.
//

import SwiftUI

struct Navigate<Destination: View>: View {
    @Binding var when: Bool
    var destination: () -> Destination
    
    var body: some View {
        NavigationLink(isActive: $when) {
            DeferView {
                destination()
            }
        } label: { }
    }
}
