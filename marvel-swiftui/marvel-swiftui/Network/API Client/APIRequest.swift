//
//  APIRequest.swift
//  marvel-swiftui
//
//  Created by Alex Morral on 13/10/23.
//

import Foundation

/// sourcery: AutoMockable
protocol APIRequest {
    var baseURL: String { get }
    var path: String { get }
    var httpMethod: String { get }
    var httpHeaders: [String: String] { get }
    var queryItems: [URLQueryItem] { get }
    var httpBody: Data? { get }

    func buildRequest() throws -> URLRequest
}

extension APIRequest {
    var baseURL: String {
        return "https://gateway.marvel.com:443/"
    }

    func buildRequest() throws -> URLRequest {
        guard
            let url = URL(string: baseURL),
            var urlRequest = appendURLParameters(url)
        else {
            throw APIError.badURL
        }
        urlRequest.httpMethod = httpMethod
        urlRequest.httpBody = httpBody
        urlRequest.allHTTPHeaderFields = httpHeaders
        return urlRequest
    }

    var httpHeaders: [String: String] {
        [
            "Content-Type": "application/json"
        ]
    }

    var httpBody: Data? { return nil }
    var queryItems: [URLQueryItem] { [] }

    private func appendURLParameters(_ requestURL: URL) -> URLRequest? {
        guard let url = URL(string: path, relativeTo: requestURL),
              var components = URLComponents(
                url: url, resolvingAgainstBaseURL: true
              ) else {
            logger.error("Bad path name \(path)")
            return nil
        }
        var allQueryItems = queryItems.isEmpty ? [] : queryItems
        allQueryItems.append(contentsOf: authenticationQueryItems)
        components.queryItems = allQueryItems
        guard let finalURL = components.url else {
            logger.error("Failed URLComponent")
            return nil
        }
        return URLRequest(url: finalURL)
    }

    private var authenticationQueryItems: [URLQueryItem] {
        let timestamp = Date().timeIntervalSince1970
        return [
            .init(name: "apikey", value: Secret.marvelPublicAPIKey),
            .init(name: "ts", value: "\(timestamp)"),
            .init(name: "hash", value: apiHash(timestamp: timestamp))
        ]
    }

    private func apiHash(timestamp: TimeInterval) -> String {
        let stringToHash = "\(timestamp)\(Secret.marvelPrivateAPIKey)\(Secret.marvelPublicAPIKey)"
        return stringToHash.md5
    }
}
