//
// TVShowListConfigurator.swift
// TMDB-Assignment
//
// Copyright © 2023 Alex Morral. All rights reserved.
//

import UIKit

/// sourcery: AutoMockable
protocol TVShowListConfiguratorProtocol {
    func configure(_ controller: TVShowListViewController)
}

struct TVShowListConfigurator: TVShowListConfiguratorProtocol {
    func configure(_ controller: TVShowListViewController) {
        let router = TVShowListRouter(controller: controller)
        let tvShowsRepository = TVShowsRepository()

        let viewModel = TVShowListViewModel(
            router: router,
            tvShowsRepository: tvShowsRepository
        )

        controller.viewModel = viewModel

        controller.title = "TV Shows"
        controller.tabBarItem.image = UIImage(systemName: "tv.circle")
        controller.tabBarItem.selectedImage = UIImage(systemName: "tv.circle.fill")
    }
}
