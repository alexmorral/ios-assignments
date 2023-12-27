//
//  MoviesEndpoint.swift
//  TMDB-Assignment
//
//  Created by Alex Morral on 29/7/23.
//

import Foundation

enum MoviesEndpoint {
    case genres
    case movies(genre: Int, page: Int)
    case movie(movieID: Int)
}

extension MoviesEndpoint: APIRequest {
    var baseURL: String {
        "https://api.themoviedb.org/"
    }

    var path: String {
        switch self {
        case .genres:
            return "3/genre/movie/list"
        case .movies:
            return "3/discover/movie"
        case .movie(let movieID):
            return "3/movie/\(movieID)"
        }
    }

    var httpMethod: String {
        return "GET"
    }

    var queryItems: [URLQueryItem] {
        switch self {
        case .movies(let genre, let page):
            return [
                URLQueryItem(name: "with_genres", value: String(genre)),
                URLQueryItem(name: "page", value: String(page))
            ]
        default:
            return []
        }
    }
}
