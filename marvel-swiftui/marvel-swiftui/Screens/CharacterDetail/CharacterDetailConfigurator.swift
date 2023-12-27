//
// CharacterDetailConfigurator.swift
// marvel-swiftui
//
// Copyright © 2023 Alex Morral. All rights reserved.
//

import UIKit

/// sourcery: AutoMockable
protocol CharacterDetailConfiguratorProtocol {
    func configure(
        controller: CharacterDetailViewController,
        character: CharacterViewModel
    )
}

struct CharacterDetailConfigurator: CharacterDetailConfiguratorProtocol {
    func configure(
        controller: CharacterDetailViewController,
        character: CharacterViewModel
    ) {
        let router = CharacterDetailRouter(controller: controller)
        let charactersRepository = CharactersRepository()

        let viewModel = CharacterDetailViewModel(
            router: router,
            charactersRepository: charactersRepository,
            character: character
        )

        controller.viewModel = viewModel
    }
}
