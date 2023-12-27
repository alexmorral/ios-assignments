//
//  APIError.swift
//  marvel-swiftui
//
//  Created by Alex Morral on 13/10/23.
//

import Foundation

enum APIError: Error {
    case badRequest
    case badURL
    case serverError(String)
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .badRequest:
            return localizedDescription
        case .badURL:
            return localizedDescription
        case .serverError(let string):
            return string
        }
    }
}
