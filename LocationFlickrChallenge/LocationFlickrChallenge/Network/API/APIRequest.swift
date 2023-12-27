//
//  APIRequest.swift
//  LocationFlickrChallenge
//
//  Created by Alex Morral on 31/10/22.
//

import Foundation

protocol APIRequest {
    var baseURL: String { get }
    var method: String { get }
    var httpMethod: String { get }
    var httpHeaders: [String: String] { get }
    var httpBody: Data? { get }
    var queryItems: [URLQueryItem] { get }

    func buildRequest() throws -> URLRequest
}

extension APIRequest {
    var httpHeaders: [String: String] {
        [
            "Content-Type": "application/json"
        ]
    }

    func buildRequest() throws -> URLRequest {
        guard let url = URL(string: baseURL),
            var urlRequest = appendURLParameters(url) else {
            throw APIError.cannotBuildRequest
        }
        urlRequest.httpMethod = httpMethod
        urlRequest.httpBody = httpBody
        urlRequest.allHTTPHeaderFields = httpHeaders

        return urlRequest
    }

    private func appendURLParameters(_ requestURL: URL) -> URLRequest? {
        guard var components = URLComponents(url: requestURL, resolvingAgainstBaseURL: true) else {
            print("Bad url \(requestURL.absoluteString)")
            return nil
        }
        components.queryItems = queryItems
        guard let finalURL = components.url else {
            print("Failed URLComponent")
            return nil
        }
        return URLRequest(url: finalURL)
    }
}
