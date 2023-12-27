//
//  APIRequest.swift
//  TMDB-Assignment
//
//  Created by Alex Morral on 29/7/23.
//

import Foundation

protocol APIRequest {
    var baseURL: String { get }
    var path: String { get }
    var httpMethod: String { get }
    var httpHeaders: [String: String] { get }
    var httpBody: Data? { get }
    var queryItems: [URLQueryItem] { get }

    func buildRequest() throws -> URLRequest
}

// swiftlint:disable line_length
extension APIRequest {
    func buildRequest() throws -> URLRequest {
        guard var urlComponents = URLComponents(string: "\(baseURL)\(path)") else {
            throw APIError.badURL
        }
        if !queryItems.isEmpty {
            urlComponents.queryItems = queryItems
        }
        guard let url = urlComponents.url else { throw APIError.badURL }
        var urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = httpHeaders
        urlRequest.httpMethod = httpMethod
        urlRequest.httpBody = httpBody
        return urlRequest
    }

    var httpHeaders: [String: String] {
        [
            "Content-Type": "application/json",
            "Authorization": "Bearer XXX"
        ]
    }

    var httpBody: Data? { nil }
}
// swiftlint:enable line_length
