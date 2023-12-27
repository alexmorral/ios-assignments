//
//  Endpoint.swift
//  marvel-swiftui
//
//  Created by Alex Morral on 13/10/23.
//

import Foundation

enum MarvelEndpoint {
    case characters(offset: Int)
    case character(id: Int)
}

extension MarvelEndpoint: APIRequest {
    var path: String {
        switch self {
        case .characters:
            return "v1/public/characters"
        case .character(let id):
            return "v1/public/characters/\(id)"
        }
    }

    var httpMethod: String {
        return "GET"
    }

    var queryItems: [URLQueryItem] {
        switch self {
        case .characters(let offset):
            return [
                .init(name: "offset", value: "\(offset)")
            ]
        default:
            return []
        }
    }

}
