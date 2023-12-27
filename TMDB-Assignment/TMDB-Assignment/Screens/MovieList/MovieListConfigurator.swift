//
// MovieListConfigurator.swift
// TMDB-Assignment
//
// Copyright © 2023 Alex Morral. All rights reserved.
//

import UIKit

/// sourcery: AutoMockable
protocol MovieListConfiguratorProtocol {
    func configure(_ controller: MovieListViewController)
}

struct MovieListConfigurator: MovieListConfiguratorProtocol {
    func configure(_ controller: MovieListViewController) {
        let router = MovieListRouter(controller: controller)
        let moviesRepository = MoviesRepository()

        let viewModel = MovieListViewModel(
            router: router,
            moviesRepository: moviesRepository
        )

        controller.viewModel = viewModel
        controller.title = "Movies"
        controller.tabBarItem.image = UIImage(systemName: "popcorn.circle")
        controller.tabBarItem.selectedImage = UIImage(systemName: "popcorn.circle.fill")
    }
}
