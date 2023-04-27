//
//  ErrorPopup.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 22/04/2023.
//

import SwiftUI

struct ErrorPopup: ViewModifier {
    @Binding var isPresented: Bool
    let errorMessage: String?
    var onCancel: (() -> Void)?
    var onAction: (() -> Void)?

    @ViewBuilder
    func body(content: Content) -> some View {
        content
            .popup(isPresented: $isPresented, content: {
                AlertView(
                    title: "error.title",
                    message: errorMessage,
                    cancelButtonTitle: "error.cancel.button.title",
                    mainButtonTitle: "error.retry.button.title",
                    onCancel: {
                        isPresented = false
                        onCancel?()
                    },
                    onAction: {
                        isPresented = false
                        onAction?()
                    }
                )
            })
    }
}

extension View {
    func errorPopup(
        isPresented: Binding<Bool>,
        errorMessage: String?,
        onCancel: (() -> Void)?,
        onAction: (() -> Void)?
    ) -> some View {
        self.modifier(
            ErrorPopup(
                isPresented: isPresented,
                errorMessage: errorMessage,
                onCancel: onCancel,
                onAction: onAction
            )
        )
    }
}
