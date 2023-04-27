//
//  TemplateRouter.swift
//  
//  Created by Denis Kutlubaev on 01.03.2023.
//

import Combine
import Foundation
import SwiftUI

enum TemplateRoute: Equatable {
    case none
    case route1
    case route2(variant: TemplateVariant)
}

@MainActor
final class TemplateRouter: ObservableObject {
    @Published private(set) var currentRoute: TemplateRoute = .none
    @Published var isRouteShowing = false

    func open(_ route: TemplateRoute) {
        currentRoute = route
        isRouteShowing = route != .none
    }

    @ViewBuilder
    func getCurrentView(model: Model) -> some View {
        let isPresented = Binding(
            get: { self.isRouteShowing },
            set: { self.isRouteShowing = $0 }
        )

        switch currentRoute {
        case .route1:
            getView1(model: model, isPresented: isPresented)
        case .route2(let variant):
            getView2(variant: variant, model: model, isPresented: isPresented)
        case .none:
            EmptyView()
        }
    }

    @ViewBuilder
    private func getView1(model: Model, isPresented: Binding<Bool>) -> some View {
        TemplateView1(
            viewModel: TemplateViewModel1(
                authService: model.authService,
                storeKitService: model.storeKitService
            ),
            isPresented: isPresented
        )
        .environmentObject(model)
    }

    @ViewBuilder
    private func getView2(variant: TemplateVariant, model: Model, isPresented: Binding<Bool>) -> some View {
        TemplateView2(
            viewModel: TemplateViewModel2(
                authService: model.authService,
                storeKitService: model.storeKitService,
                variant: variant
            ),
            isPresented: isPresented
        )
        .environmentObject(model)
    }
}


