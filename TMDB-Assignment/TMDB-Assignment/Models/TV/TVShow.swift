//
//  TVShow.swift
//  TMDB-Assignment
//
//  Created by Alex Morral on 30/7/23.
//

import Foundation

struct TVShow: Codable {
    let id: Int
    let name: String
    let posterPath: String
    let rating: Double
    let lastAirDate: String?
    let lastEpisodeToAir: TVShowEpisode?

    var imageURL: URL? {
        URL(string: "https://image.tmdb.org/t/p/w200/\(posterPath)")
    }

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case posterPath = "poster_path"
        case rating = "vote_average"
        case lastAirDate = "last_air_date"
        case lastEpisodeToAir = "last_episode_to_air"
    }
}

struct TVShowEpisode: Codable {
    let id: Int
    let name: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}

extension TVShow: Identifiable {}
extension TVShow: Equatable {}
extension TVShowEpisode: Equatable {}
