//
//  TVShowsRepository.swift
//  TMDB-Assignment
//
//  Created by Alex Morral on 30/7/23.
//

import Foundation

/// sourcery: AutoMockable
protocol TVShowsRepositoryProtocol {
    func genres() async throws -> [TVGenre]
    func tvShows(genreID: Int, forceReload: Bool) async throws -> [TVShow]
    func tvShow(tvShowID: Int) async throws -> TVShow
}

class TVShowsRepository: TVShowsRepositoryProtocol {
    private let apiClient: APIClientProtocol
    private let decoder = JSONDecoder()

    var tvShowsPagination: PaginatedAPIResult<[TVShow]>?

    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }

    func genres() async throws -> [TVGenre] {
        let apiResult: TVGenresAPIResult = try await apiClient.performRequest(
            apiRequest: TVShowsEndpoint.genres,
            decoder: decoder
        )

        return apiResult.genres
    }

    func tvShows(genreID: Int, forceReload: Bool) async throws -> [TVShow] {
        let nextTVShowsPage = nextTVShowsPage(forceReload: forceReload)
        guard shouldDownloadNextTVShowsPage(nextPage: nextTVShowsPage) else {
            // We could throw a specific error here to handle in the ViewModel
            return []
        }
        let apiResult: PaginatedAPIResult<[TVShow]> = try await apiClient
            .performRequest(
                apiRequest: TVShowsEndpoint.tvShows(
                    genre: genreID,
                    page: nextTVShowsPage
                ),
                decoder: decoder
            )
        tvShowsPagination = apiResult
        return apiResult.results
    }

    func tvShow(tvShowID: Int) async throws -> TVShow {
        return try await apiClient.performRequest(
            apiRequest: TVShowsEndpoint.tvShow(tvShowID: tvShowID),
            decoder: decoder
        )
    }

    private func shouldDownloadNextTVShowsPage(nextPage: Int) -> Bool {
        guard let tvShowsPagination else { return true }
        return nextPage <= tvShowsPagination.totalPages
    }

    private func nextTVShowsPage(forceReload: Bool) -> Int {
        guard let tvShowsPagination else { return 1 }
        return forceReload ? 1 : tvShowsPagination.page + 1
    }
}
