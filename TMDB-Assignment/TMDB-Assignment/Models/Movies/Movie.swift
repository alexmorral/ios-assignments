//
//  Movie.swift
//  TMDB-Assignment
//
//  Created by Alex Morral on 29/7/23.
//

import Foundation

struct Movie: Codable {
    let id: Int
    let title: String
    let posterPath: String
    let rating: Double
    let budget: Double?
    let revenue: Double?

    var imageURL: URL? {
        URL(string: "https://image.tmdb.org/t/p/w200/\(posterPath)")
    }

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case rating = "vote_average"
        case budget
        case revenue
    }
}

extension Movie: Identifiable {}
extension Movie: Equatable {}
