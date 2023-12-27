//
//  APIClient.swift
//  LocationFlickrChallenge
//
//  Created by Alex Morral on 31/10/22.
//

import Foundation

protocol APIClientProtocol {
    func performRequest(apiRequest: APIRequest) async throws -> Data
}

struct APIClient: APIClientProtocol {
    var session = URLSession.shared

    func performRequest(apiRequest: APIRequest) async throws -> Data {
        let urlRequest = try apiRequest.buildRequest()
        let (data, urlResponse) = try await session.data(for: urlRequest)
        guard let httpResponse = urlResponse as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
                  throw APIError.badRequest
        }
        return data
    }
}
