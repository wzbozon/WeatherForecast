//
//  TemplateViewModel.swift
//
//  Created by Denis Kutlubaev on 12.12.2022.
//

import Combine
import Foundation

/// MVVM ViewModel Template
@MainActor
final class TemplateViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var isShowingError = false
    @Published var errorMessage: String?
    @Published var isShowingNextView = false
    @Published var item: Item?
    @Published var isItemLoaded = false

    private let templateService: TemplateService
    private let notificationCenter = NotificationCenter.default
    private var disposeBag = Set<AnyCancellable>()

    init(templateService: TemplateService) {
        self.templateService = templateService

        setupSubscriptions()
    }

    func fetchItem() {
        templateService.clearItem()
        Task {
            try? await templateService.getItem(itemId: itemId)
        }
    }
}

// MARK: - Private

private extension TemplateViewModel {
    func setupSubscriptions() {
        templateService.$itemLoadingState
            .sink { [unowned self] state in
                switch state {
                case .loaded(let item):
                    self.item = item
                case .failed(let error):
                    isShowingError = true
                    if let error = error as? RequestError {
                        errorMessage = error.message
                    } else {
                        errorMessage = "Unhandled error"
                    }
                default:
                    break
                }
            }
            .store(in: &disposeBag)

        templateService.$itemLoadingState
            .map { state in
                if case .loading = state { return true }
                return false
            }
            .assign(to: \.isLoading, on: self)
            .store(in: &disposeBag)

        notificationCenter
            .publisher(for: .play)
            .sink { [unowned self] _ in
                // Call a function
            }
            .store(in: &disposeBag)

        $item
            .sink { [unowned self] _ in
                // Call a function
            }
            .store(in: &disposeBag)
        
        $isItemLoaded
            .assign(to: \.isShowingNextView, on: self)
            .store(in: &disposeBag)
    }
}
