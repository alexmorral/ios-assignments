//
//  Genre.swift
//  TMDB-Assignment
//
//  Created by Alex Morral on 29/7/23.
//

import Foundation
import RxSwift

struct MovieGenresAPIResult: Codable {
    let genres: [MovieGenre]
}

struct MovieGenre: Codable {
    let id: Int
    let name: String
}

extension MovieGenre: Identifiable {}
extension MovieGenre: Equatable {}
