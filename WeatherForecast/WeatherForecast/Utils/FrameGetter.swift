//
//  FrameGetter.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 22/04/2023.
//

import SwiftUI

struct FrameGetter: ViewModifier {
    @Binding var frame: CGRect
    
    func body(content: Content) -> some View {
        content.background(
            GeometryReader { proxy -> AnyView in
                let rect = proxy.frame(in: .global)
                
                // This avoids an infinite layout loop
                if rect.integral != self.frame.integral {
                    DispatchQueue.main.async {
                        self.frame = rect
                    }
                }
                
                return AnyView(EmptyView())
            }.ignoresSafeArea()
        )
    }
}

extension View {
    func frameGetter(_ frame: Binding<CGRect>) -> some View {
        modifier(FrameGetter(frame: frame))
    }
}
