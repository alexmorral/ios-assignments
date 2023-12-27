//
//  MoviesRepository.swift
//  TMDB-Assignment
//
//  Created by Alex Morral on 29/7/23.
//

import Foundation
import RxSwift

/// sourcery: AutoMockable
protocol MoviesRepositoryProtocol {
    func genres() async throws -> [MovieGenre]
    func movies(genreID: Int, forceReload: Bool) async throws -> [Movie]
    func movie(movieID: Int) async throws -> Movie
    // RXSwift
    func rxGenres() throws -> Observable<[MovieGenre]>
}

class MoviesRepository: MoviesRepositoryProtocol {
    private let apiClient: APIClientProtocol
    private let decoder = JSONDecoder()

    let backgroundWorkScheduler: ImmediateSchedulerType

    var moviesPagination: PaginatedAPIResult<[Movie]>?

    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient

        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 2
        operationQueue.qualityOfService = QualityOfService.userInitiated
        backgroundWorkScheduler = OperationQueueScheduler(operationQueue: operationQueue)
    }

    func genres() async throws -> [MovieGenre] {
        let apiResult: MovieGenresAPIResult = try await apiClient.performRequest(
            apiRequest: MoviesEndpoint.genres,
            decoder: decoder
        )

        return apiResult.genres
    }

    func movies(genreID: Int, forceReload: Bool) async throws -> [Movie] {
        let nextMoviesPage = nextMoviesPage(forceReload: forceReload)
        guard shouldDownloadNextMoviesPage(nextPage: nextMoviesPage) else {
            // We could throw a specific error here to handle in the ViewModel
            return []
        }
        let apiResult: PaginatedAPIResult<[Movie]> = try await apiClient
            .performRequest(
                apiRequest: MoviesEndpoint.movies(
                    genre: genreID,
                    page: nextMoviesPage
                ),
                decoder: decoder
            )
        moviesPagination = apiResult
        return apiResult.results
    }

    func movie(movieID: Int) async throws -> Movie {
        return try await apiClient.performRequest(
            apiRequest: MoviesEndpoint.movie(movieID: movieID),
            decoder: decoder
        )
    }

    private func shouldDownloadNextMoviesPage(nextPage: Int) -> Bool {
        guard let moviesPagination else { return true }
        return nextPage <= moviesPagination.totalPages
    }

    private func nextMoviesPage(forceReload: Bool) -> Int {
        guard let moviesPagination else { return 1 }
        return forceReload ? 1 : moviesPagination.page + 1
    }

    // RXSwift

    func rxGenres() throws -> Observable<[MovieGenre]> {
        try apiClient
            .performRXRequest(apiRequest: MoviesEndpoint.genres)
            .observe(on: backgroundWorkScheduler)
            .map { json in
                guard let json = json as? NSDictionary,
                let jsonGenres = json["genres"] as? [Any] else {
                    throw APIError.badRequest
                }
                let jsonData = try JSONSerialization.data(withJSONObject: jsonGenres, options: .prettyPrinted)

                return try self.decoder.decode([MovieGenre].self, from: jsonData)
            }
            .observe(on: MainScheduler.instance)
    }
}
