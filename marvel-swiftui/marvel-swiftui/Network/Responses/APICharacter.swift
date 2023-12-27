//
//  APICharacter.swift
//  marvel-swiftui
//
//  Created by Alex Morral on 13/10/23.
//

import Foundation

struct APICharacterDataWrapper: Codable {
    let code: Int
    let data: APICharacterDataContainer
}

struct APICharacterDataContainer: Codable {
    let offset, limit, total, count: Int
    let results: [APICharacter]
}

struct APICharacter: Codable {
    let id: Int
    let name: String
    let thumbnail: APIImage
    let comics: APIComicList

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case thumbnail
        case comics
    }
}
struct APIImage: Codable {
    let path: String
    let imageExtension: String

    enum CodingKeys: String, CodingKey {
        case path
        case imageExtension = "extension"
    }
}

struct APIComicList: Codable {
    let items: [APIComicSummary]
}

struct APIComicSummary: Codable {
    let resourceURI: String
    let name: String
}
