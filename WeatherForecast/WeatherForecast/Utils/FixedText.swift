//
//  FixedText.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 22/04/2023.
//

import SwiftUI

struct FixedText: ViewModifier {
    @ViewBuilder
    func body(content: Content) -> some View {
        content
            .fixedSize(horizontal: false, vertical: true)
    }
}

extension View {
    func fixedText() -> some View {
        self.modifier(FixedText())
    }
}
