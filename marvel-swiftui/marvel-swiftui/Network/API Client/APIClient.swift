//
//  APIClient.swift
//  marvel-swiftui
//
//  Created by Alex Morral on 13/10/23.
//

import Foundation

protocol APIClientProtocol {
    func performRequest<T: Codable>(
        apiRequest: APIRequest,
        decoder: JSONDecoder
    ) async throws -> T
}

class APIClient: APIClientProtocol {
    var session = URLSession.shared

    func performRequest<T: Codable>(
        apiRequest: APIRequest,
        decoder: JSONDecoder
    ) async throws -> T {
        let urlRequest = try apiRequest.buildRequest()
        printRequestInfo(request: urlRequest)
        let (data, urlResponse) = try await session.data(for: urlRequest)
        guard let httpResponse = urlResponse as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            logger.error(String(data: data, encoding: .utf8) ?? "Empty error")
            throw APIError.badRequest
        }
        printResponseInfo(response: httpResponse, data: data)
        return try decoder.decode(T.self, from: data)
    }

    private func printRequestInfo(request: URLRequest) {
        logger.debug("*** REQUEST ***")
        logger.debug("Executing \(request.httpMethod ?? "-") request to \(request.url?.absoluteString ?? "??")")
        if let httpHeaders = request.allHTTPHeaderFields, !httpHeaders.isEmpty {
            logger.debug("*** REQUEST HTTP HEADERS ***")
            logger.debug(httpHeaders)
        }
        if let httpBody = request.httpBody,
           let requestJson = try? JSONSerialization.jsonObject(with: httpBody) {
            logger.debug("*** REQUEST HTTP BODY ***")
            logger.debug(requestJson)
        }
    }

    private func printResponseInfo(response: HTTPURLResponse, data: Data?) {
        logger.debug("*** RESPONSE ***")
        logger.debug("Status code: \(response.statusCode)")
        if let data,
           let responseJson = try? JSONSerialization.jsonObject(with: data) {
            logger.debug("*** RESPONSE BODY ***")
            logger.debug(responseJson)
        }
    }
}
