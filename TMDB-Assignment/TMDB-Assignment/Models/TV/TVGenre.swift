//
//  TVGenre.swift
//  TMDB-Assignment
//
//  Created by Alex Morral on 29/7/23.
//

import Foundation

struct TVGenresAPIResult: Codable {
    let genres: [TVGenre]
}

struct TVGenre: Codable {
    let id: Int
    let name: String
}

extension TVGenre: Identifiable {}
extension TVGenre: Equatable {}
