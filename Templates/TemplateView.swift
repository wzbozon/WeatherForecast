//
//  TemplateView.swift
//
//  Created by Denis Kutlubaev on 12.12.2022.
//

import SwiftUI

/// MVVM View Template
struct TemplateView: View {

    @StateObject private var viewModel: TemplateViewModel
    @StateObject private var router: DebugMenuRouter
    @EnvironmentObject private var model: Model
    @Binding private var isPresented: Bool
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.safeAreaInsets) private var safeAreaInsets

    init(viewModel: TemplateViewModel, router: TemplateRouter, isPresented: Binding<Bool>) {
        _viewModel = StateObject(wrappedValue: viewModel)
        _router = StateObject(wrappedValue: router)
        _isPresented = isPresented
    }

    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                Text("Hello, World!")

                Button {
                    viewModel.getItems()
                } label: {
                    if viewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    } else {
                        Text("continue.button.title".localize())
                    }
                }
                .buttonStyle(.primary)

                Button("Open TemplateView1") {
                    router.open(.route1)
                }

                Button("Open TemplateView2") {
                    router.open(.route2)
                }
            }

            CloseButton {
                isPresented = false
            }
        }
        .filled(with: .appBackground)
        .fullScreenCover(isPresented: $router.isRouteShowing) {
            router.getCurrentView(model: model)
        }
        .background(
            Navigate(when: $viewModel.isShowingNextView) {
                TemplateView(
                    viewModel: TemplateViewModel(
                        authService: model.authService,
                        courseService: model.courseService
                    )
                )
                .environmentObject(model)
            }
        )
        .errorPopup(
            isPresented: $viewModel.isShowingError,
            errorMessage: viewModel.errorMessage,
            onCancel: {
                presentationMode.wrappedValue.dismiss()
            },
            onAction: {
                viewModel.fetchItem()
            }
        )
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButton(presentationMode: _presentationMode))
    }

    private enum Constants {
        static let someConstant: CGFloat = 1
    }
}

// MARK: - PreviewProvider

struct TemplateView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TemplateView(
                viewModel: .init(
                    authService: .init(),
                    courseService: .init()
                ),
                router: .init()
                isPresented: .constant(false)
            )
            .environmentObject(Model())
        }
    }
}
