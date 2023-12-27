//
// CharacterListConfigurator.swift
// marvel-swiftui
//
// Copyright © 2023 Alex Morral. All rights reserved.
//

import UIKit

/// sourcery: AutoMockable
protocol CharacterListConfiguratorProtocol {
    func configure(controller: CharacterListViewController)
}

struct CharacterListConfigurator: CharacterListConfiguratorProtocol {
    func configure(controller: CharacterListViewController) {
        let router = CharacterListRouter(controller: controller)

        let charactersRepository = CharactersRepository()

        let viewModel = CharacterListViewModel(
            router: router,
            charactersRepository: charactersRepository
        )

        controller.viewModel = viewModel
    }
}
