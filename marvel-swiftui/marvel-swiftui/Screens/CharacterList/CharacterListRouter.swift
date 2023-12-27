//
// CharacterListRouter.swift
// marvel-swiftui
//
// Copyright © 2023 Alex Morral. All rights reserved.
//

import UIKit

/// sourcery: AutoMockable
protocol CharacterListRouterProtocol {
    func presentCharacterDetail(character: CharacterViewModel)
    func dismiss()
}

class CharacterListRouter: CharacterListRouterProtocol {
    private weak var controller: CharacterListViewController?

    init(controller: CharacterListViewController) {
        self.controller = controller
    }

    func presentCharacterDetail(character: CharacterViewModel) {
        let viewController = CharacterDetailViewController()
        let configurator = CharacterDetailConfigurator()
        configurator.configure(
            controller: viewController,
            character: character
        )

        controller?.navigationController?.pushViewController(viewController, animated: true)
    }

    func dismiss() {
        self.controller?.dismiss(animated: true, completion: nil)
    }
}
