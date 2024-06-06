//
//  APIManager.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 22/04/2023.
//

import Foundation
import OSLog

class APIManager {

    func sendRequest (
        endpoint: Endpoint,
        isDebug: Bool = false
    ) async throws -> (Data, URLResponse) {
        guard let url = endpoint.url,
              let urlRequest = createRequest(with: url, endpoint: endpoint)
        else {
            throw RequestError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        #if DEBUG
        log(url, urlRequest.httpBody, data)
        #endif

        return (data, response)
    }
}

// MARK: - Private

private extension APIManager {
    func createGetRequestWithURLComponents(
        url: URL,
        endpoint: Endpoint
    ) -> URLRequest? {
        var components = URLComponents(string: url.absoluteString)!
        components.queryItems = endpoint.parameters?.compactMap { (key, value) in
            URLQueryItem(name: key, value: "\(value)")
        }
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        var request = URLRequest(url: components.url ?? url)
        request.httpMethod = endpoint.requestType.rawValue
        
        request.allHTTPHeaderFields = endpoint.header ?? [:]
        
        return request
    }
    
    func createPostRequestWithBody(
        url: URL,
        endpoint: Endpoint
    ) -> URLRequest? {
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.requestType.rawValue
        request.allHTTPHeaderFields = endpoint.header
        
        if let requestBody = getParameterBody(with: endpoint.parameters) {
            request.httpBody = requestBody
        }
        
        request.httpMethod = endpoint.requestType.rawValue
        return request
    }
    
    func getParameterBody(with parameters: [String: Any]?) -> Data? {
        guard let parameters,
              let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) else {
            return nil
        }
        return httpBody
    }
    
    func createRequest(
        with url: URL,
        endpoint: Endpoint
    ) -> URLRequest? {
        switch endpoint.requestType {
        case .get:
            return createGetRequestWithURLComponents(
                url: url,
                endpoint: endpoint
            )
        case .post, .put, .patch, .delete:
            return createPostRequestWithBody(
                url: url,
                endpoint: endpoint
            )
        }
    }
    
    func log(_ url: URL, _ body: Data?, _ data: Data) {
        debugPrint("Request URL: \(url)")
        Logger.default.log("[APIManager] Request URL: \(url, privacy: .public)")
        
        if let body = body, let bodyJSON = body.prettyPrintedJSONString {
            Logger.default.log("[APIManager] Request HTTP Body: \(bodyJSON, privacy: .public)")
        }
        
        if let str = data.prettyPrintedJSONString {
            debugPrint(str)
            Logger.default.log("[APIManager] \(str, privacy: .public)")
        } else {
            debugPrint("🛬", String(decoding: data, as: UTF8.self))
            Logger.default.log("[APIManager] \(String(decoding: data, as: UTF8.self), privacy: .public)")
        }
    }
}
