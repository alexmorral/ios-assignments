//
//  APIClient.swift
//  TMDB-Assignment
//
//  Created by Alex Morral on 29/7/23.
//

import Foundation
import RxSwift
import RxCocoa

/// sourcery: AutoMockable
protocol APIClientProtocol {
    func performRequest<T: Codable>(
        apiRequest: APIRequest,
        decoder: JSONDecoder
    ) async throws -> T
    // RXSwift
    func performRXRequest(apiRequest: APIRequest) throws -> Observable<Any>
}

class APIClient: APIClientProtocol {
    let urlSession: URLSession

    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }

    func performRequest<T: Codable>(
        apiRequest: APIRequest,
        decoder: JSONDecoder
    ) async throws -> T {
        let urlRequest = try apiRequest.buildRequest()
        printRequest(urlRequest: urlRequest)
        let (data, urlResponse) = try await urlSession.data(for: urlRequest)
        guard let httpResponse = urlResponse as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw APIError.badRequest
        }
        printResponse(urlResponse: httpResponse)
        return try decoder.decode(T.self, from: data)
    }

    private func printRequest(urlRequest: URLRequest) {
        print("*** REQUEST ***")
        print("\(urlRequest.httpMethod!) \(urlRequest.url!)")
    }

    private func printResponse(urlResponse: HTTPURLResponse) {
        print("*** RESPONSE ***")
        print("\(urlResponse.statusCode)")
    }

    // RXSwift

    func performRXRequest(apiRequest: APIRequest) throws -> Observable<Any> {
        let urlRequest = try apiRequest.buildRequest()
        return urlSession
            .rx.json(request: urlRequest)
    }
}
