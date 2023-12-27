//
// TVShowListViewModel.swift
// TMDB-Assignment
//
// Copyright © 2023 Alex Morral. All rights reserved.
//

import UIKit
import SwiftUI
import Combine

/// sourcery: AutoMockable
protocol TVShowListViewModelProtocol {
    var tvGenres: [TVGenre] { get set }
    var selectedGenre: TVGenre? { get set }
    var tvShows: [TVShow] { get set }

    func loadGenres() async
    func loadTVShows(forceReload: Bool) async
    func loadNextTVShowsPage()
    func loadTVShow(with tvShowID: Int) async
}

final class TVShowListViewModel: TVShowListViewModelProtocol, ObservableObject {
    private let router: TVShowListRouterProtocol
    private let tvShowsRepository: TVShowsRepositoryProtocol
    private var bindingsSet = Set<AnyCancellable>()

    @Published var tvGenres = [TVGenre]()
    @Published var selectedGenre: TVGenre?
    @Published var tvShows = [TVShow]()

    init(
        router: TVShowListRouterProtocol,
        tvShowsRepository: TVShowsRepositoryProtocol
    ) {
        self.router = router
        self.tvShowsRepository = tvShowsRepository
    }

    func setup() {
        bindings()
        Task { @MainActor in
            await loadGenres()
        }
    }

    func bindings() {
        let handleGenreChanged: (TVGenre?) -> Void = { [weak self] _ in
            guard let self = self else { return }
            Task { @MainActor in
                await self.loadTVShows(forceReload: true)
            }
        }

        $selectedGenre
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: handleGenreChanged)
            .store(in: &bindingsSet)
    }

    @MainActor
    func loadGenres() async {
        do {
            tvGenres = try await tvShowsRepository.genres()
            selectedGenre = tvGenres.first
        } catch {
            // Show some error in the view
            // viewState = .error
            print(error.localizedDescription)
        }
    }

    @MainActor
    func loadTVShows(forceReload: Bool) async {
        guard let genreID = selectedGenre?.id else { return }
        do {
            if forceReload {
                tvShows = []
            }
            let newTVShows = try await tvShowsRepository.tvShows(
                genreID: genreID,
                forceReload: forceReload
            )
            tvShows.append(contentsOf: newTVShows)
            for tvShow in tvShows {
                await loadTVShow(with: tvShow.id)
            }
        } catch {
            // Show some error in the view
            // viewState = .error
            print(error.localizedDescription)
        }
    }

    func loadNextTVShowsPage() {
        Task { @MainActor in
            await loadTVShows(forceReload: false)
        }
    }

    @MainActor
    func loadTVShow(with tvShowID: Int) async {
        do {
            let tvShow = try await tvShowsRepository.tvShow(tvShowID: tvShowID)
            if let tvShowIndex = tvShows.firstIndex(where: { $0.id == tvShow.id}) {
                tvShows[tvShowIndex] = tvShow
            }
        } catch {
            // Show some error in the view
            // viewState = .error
            print(error.localizedDescription)
        }
    }
}
