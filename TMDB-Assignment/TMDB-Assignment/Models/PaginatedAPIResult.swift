//
//  PaginatedAPIResult.swift
//  TMDB-Assignment
//
//  Created by Alex Morral on 29/7/23.
//

import Foundation

struct PaginatedAPIResult<T: Codable>: Codable {
    let page: Int
    let totalPages: Int
    let totalResults: Int

    let results: T

    enum CodingKeys: String, CodingKey {
        case page
        case totalPages  = "total_pages"
        case totalResults = "total_results"
        case results
    }
}
