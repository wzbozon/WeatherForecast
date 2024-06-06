//
//  TemplateService.swift
//
//  Created by Denis Kutlubaev on 08.02.2023.
//

import Combine
import Foundation

// MARK: - TemplateServiceEndpoint

enum TemplateServiceEndpoint: Endpoint {

    case getItems

    var path: String {
        switch self {
        case .getItems:
            return API.getItems
        }
    }

    var requestType: RequestType {
        return .get
    }

    var parameters: [String: Any]? {
        switch self {
        case .getItems:
            return nil
        }
    }
}

// MARK: - TemplateServiceError

enum TemplateServiceError: Error {
    case pending
    case failed
    case cancelled
}

// MARK: - TemplateService

class TemplateService: ObservableObject {
    @Published private(set) var itemLoadingState: LoadingState<[Item]> = .idle

    private let store: TemplateServiceStoreProtocol

    init(isDebug: Bool = false) {
        print("[TemplateService] init")

        store = isDebug ? TemplateServiceStoreMock() : TemplateServiceStore()

        Task {
            print("[TemplateService] Fetch items started...")
            try? await fetchItems()
            print("[TemplateService] Fetch items finished.")
        }
    }

    deinit {
        print("[TemplateService] deinit")
    }

    @MainActor
    func fetchItems() async throws {
        itemLoadingState = .loading

        do {
            let items = try await store.fetchItems()
            itemLoadingState = .loaded(items)
        } catch {
            itemLoadingState = .failed(error)
        }
    }

    @MainActor
    func reset() {
        itemLoadingState = .idle
    }
}

// MARK: - TemplateServiceStoreProtocol

protocol TemplateServiceStoreProtocol {
    func fetchItems() async throws
}

// MARK: - TemplateServiceStore

private actor TemplateServiceStore: TemplateServiceStoreProtocol {
    func fetchItems() async throws -> [Item] {
        guard let result = await APIManager.shared.sendRequest(
            model: APIResponse<[Item]> .self,
            endpoint: TemplateServiceEndpoint.items
        ) else {
            throw RequestError.statusNotOk
        }

        switch result {
        case .success(let response):
            return response
        case .failure:
            throw RequestError.statusNotOk
        }
    }

    private enum Constants {
        static let templateConstant = "templateConstant"
    }
}

// MARK: - TemplateServiceStoreMock

private actor TemplateServiceStoreMock: TemplateServiceStoreProtocol {
    func fetchItems() async throws -> [Item] {
        try await Task.sleep(seconds: 1)

        // To simulate error:
        // throw TemplateServiceError.failed

        // To simulate success:
        let item1 = Item()
        let item2 = Item()

        return [item1, item2]
    }
}
