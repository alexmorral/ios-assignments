//
//  TVShowsEndpoint.swift
//  TMDB-Assignment
//
//  Created by Alex Morral on 30/7/23.
//

import Foundation

enum TVShowsEndpoint {
    case genres
    case tvShows(genre: Int, page: Int)
    case tvShow(tvShowID: Int)
}

extension TVShowsEndpoint: APIRequest {
    var baseURL: String {
        "https://api.themoviedb.org/"
    }

    var path: String {
        switch self {
        case .genres:
            return "3/genre/tv/list"
        case .tvShows:
            return "3/discover/tv"
        case .tvShow(let tvShowID):
            return "3/tv/\(tvShowID)"
        }
    }

    var httpMethod: String {
        return "GET"
    }

    var queryItems: [URLQueryItem] {
        switch self {
        case .tvShows(let genre, let page):
            return [
                URLQueryItem(name: "with_genres", value: String(genre)),
                URLQueryItem(name: "page", value: String(page))
            ]
        default:
            return []
        }
    }
}
