//
//  AlertView.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 22/04/2023.
//

import SwiftUI

struct AlertView: View {
    let title: String
    let message: String?
    let cancelButtonTitle: String
    let mainButtonTitle: String
    let onCancel: () -> Void
    let onAction: () -> Void

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: CornerRadius.small)
                .foregroundColor(.white)
                .layoutPriority(-1)

            VStack(spacing: 0) {
                Text(title)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .fixedText()
                    .padding(.vertical)
                    .padding(.horizontal, Padding.medium)

                if let message = message {
                    Text(message)
                        .foregroundColor(.white)
                        .font(.caption2)
                        .multilineTextAlignment(.center)
                        .fixedText()
                        .padding(.bottom)
                        .padding(.horizontal, Padding.medium)
                }

                Divider()
                    .overlay(Color.white)

                HStack(spacing: 0) {
                    Button(cancelButtonTitle) {
                        onCancel()
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)

                    Divider()
                        .overlay(Color.white)
                        .frame(height: UIConstants.buttonHeight)

                    Button(mainButtonTitle) {
                        onAction()
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                }
            }
        }
        .frame(width: Constants.alertWidth)
    }

    private enum Constants {
        static let alertWidth: CGFloat = 270
    }
}

struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            AlertView(
                title: "paywall.gift.alert.title",
                message: nil,
                cancelButtonTitle: "paywall.gift.skip.button.title",
                mainButtonTitle: "paywall.gift.cancel.button.title",
                onCancel: {},
                onAction: {}
            )
        }
    }
}
