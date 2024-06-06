//
//  Popup.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 22/04/2023.
//

import SwiftUI

struct Popup<PopupContent>: ViewModifier where PopupContent: View {

    @Binding var isPresented: Bool

    var content: () -> PopupContent

    private let hugeOffset: CGFloat = 1000
    private let additionalOffset: CGFloat = 5
    private let springStiffness: CGFloat = 170
    private let springDamping: CGFloat = 15

    @State private var presenterContentRect: CGRect = .zero
    @State private var sheetContentRect: CGRect = .zero

    private var displayedOffset: CGFloat {
        -presenterContentRect.midY + UIConstants.screenSize.height / 2.0
    }

    private var hiddenOffset: CGFloat {
        guard !presenterContentRect.isEmpty else { return hugeOffset }

        return UIConstants.screenSize.height
        - presenterContentRect.midY
        + sheetContentRect.height / 2.0
        + additionalOffset
    }

    private var currentOffset: CGFloat {
        return isPresented ? displayedOffset : hiddenOffset
    }

    init(isPresented: Binding<Bool>, content: @escaping () -> PopupContent) {
        _isPresented = isPresented
        self.content = content
    }

    func body(content: Content) -> some View {
        ZStack {
            content
                .frameGetter($presenterContentRect)

            if isPresented {
                popupBackground()
            }
        }
        .overlay(
            Group {
                if isPresented {
                    sheet()
                }
            }
        )
    }

    func dismiss() {
        isPresented = false
    }

    private func sheet() -> some View {
        ZStack {
            content()
                .frameGetter($sheetContentRect)
                .frame(width: UIConstants.screenSize.width)
                .offset(x: 0, y: currentOffset)
                .animation(
                    Animation.interpolatingSpring(
                        stiffness: springStiffness,
                        damping: springDamping
                    ),
                    value: currentOffset
                )
                .ignoresSafeArea(edges: .bottom)
        }
    }

    private func popupBackground() -> some View {
        Color.gray
            .ignoresSafeArea()
            .animation(.linear, value: isPresented)
    }
}

extension View {
    func popup<Content>(
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View where Content: View {
        modifier(
            Popup(isPresented: isPresented, content: content)
        )
    }
}
