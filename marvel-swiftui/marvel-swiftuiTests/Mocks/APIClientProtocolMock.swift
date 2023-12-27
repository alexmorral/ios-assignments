//
//  APIClientProtocolMock.swift
//  marvel-swiftuiTests
//
//  Created by Alex Morral on 14/10/23.
//

import Foundation
@testable import marvel_swiftui

class APIClientProtocolMock: APIClientProtocol {
    var performRequestApiRequestDecoderThrowableError: Error?
    var performRequestApiRequestDecoderCallsCount = 0
    var performRequestApiRequestDecoderCalled: Bool {
        return performRequestApiRequestDecoderCallsCount > 0
    }

    var performRequestApiRequestDecoderReceivedArguments: (apiRequest: APIRequest, decoder: JSONDecoder)?
    var performRequestApiRequestDecoderReceivedInvocations: [(apiRequest: APIRequest, decoder: JSONDecoder)] = []
    var performRequestApiRequestDecoderReturnValue: Any!
    var performRequestApiRequestDecoderClosure: ((APIRequest, JSONDecoder) async throws -> Any)?

    func performRequest<T>(apiRequest: APIRequest, decoder: JSONDecoder) async throws -> T where T : Decodable, T : Encodable {
        if let error = performRequestApiRequestDecoderThrowableError {
            throw error
        }
        performRequestApiRequestDecoderCallsCount += 1
        performRequestApiRequestDecoderReceivedArguments = (apiRequest: apiRequest, decoder: decoder)
        performRequestApiRequestDecoderReceivedInvocations.append((apiRequest: apiRequest, decoder: decoder))
        if let performRequestApiRequestDecoderClosure = performRequestApiRequestDecoderClosure {
            return try await performRequestApiRequestDecoderClosure(apiRequest, decoder) as! T
        } else {
            return performRequestApiRequestDecoderReturnValue as! T
        }
    }
}
