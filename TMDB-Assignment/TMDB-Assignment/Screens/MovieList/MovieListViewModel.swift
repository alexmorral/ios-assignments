//
// MovieListViewModel.swift
// TMDB-Assignment
//
// Copyright © 2023 Alex Morral. All rights reserved.
//

import UIKit
import SwiftUI

import RxSwift
import Combine

/// sourcery: AutoMockable
protocol MovieListViewModelProtocol {
    var movieGenres: [MovieGenre] { get set }
    var selectedGenre: MovieGenre? { get set }
    var movies: [Movie] { get set }

    func loadGenres() async
    func loadMovies(forceReload: Bool) async
    func loadNextMoviesPage()
    func loadMovie(with movieID: Int) async
}

final class MovieListViewModel: MovieListViewModelProtocol, ObservableObject {
    private let router: MovieListRouterProtocol
    private let moviesRepository: MoviesRepositoryProtocol

    var disposeBag = DisposeBag()
    private var bindingsSet = Set<AnyCancellable>()

    @Published var movieGenres = [MovieGenre]()
    @Published var selectedGenre: MovieGenre?
    @Published var movies = [Movie]()

    init(
        router: MovieListRouterProtocol,
        moviesRepository: MoviesRepositoryProtocol
    ) {
        self.router = router
        self.moviesRepository = moviesRepository
    }

    func setup() {
        bindings()
        Task { @MainActor in
            await loadGenres()
        }
    }

    // RXSwift
//    func rxSetup() {
//        do {
//            try moviesRepository.rxGenres()
//                .subscribe(onNext: { newMovieGenres in
//                    self.movieGenres = newMovieGenres
//                })
//                .disposed(by: disposeBag)
//        } catch {
//            // Show some error in the view
//            // viewState = .error
//            print(error.localizedDescription)
//        }
//    }

    func bindings() {
        let handleMovieGenreChanged: (MovieGenre?) -> Void = { [weak self] _ in
            guard let self = self else { return }
            Task { @MainActor in
                await self.loadMovies(forceReload: true)
            }
        }

        $selectedGenre
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: handleMovieGenreChanged)
            .store(in: &bindingsSet)
    }

    @MainActor
    func loadGenres() async {
        do {
            movieGenres = try await moviesRepository.genres()
            selectedGenre = movieGenres.first
        } catch {
            // Show some error in the view
            // viewState = .error
            print(error.localizedDescription)
        }
    }

    @MainActor
    func loadMovies(forceReload: Bool) async {
        guard let genreID = selectedGenre?.id else { return }
        do {
            if forceReload {
                movies = []
            }
            let newMovies = try await moviesRepository.movies(
                genreID: genreID,
                forceReload: forceReload
            )
            movies.append(contentsOf: newMovies)
            for movie in movies {
                await loadMovie(with: movie.id)
            }
        } catch {
            // Show some error in the view
            // viewState = .error
            print(error.localizedDescription)
        }
    }

    func loadNextMoviesPage() {
        Task { @MainActor in
            await loadMovies(forceReload: false)
        }
    }

    @MainActor
    func loadMovie(with movieID: Int) async {
        do {
            let movie = try await moviesRepository.movie(movieID: movieID)
            if let movieIndex = movies.firstIndex(where: { $0.id == movie.id}) {
                movies[movieIndex] = movie
            }
        } catch {
            // Show some error in the view
            // viewState = .error
            print(error.localizedDescription)
        }
    }
}
