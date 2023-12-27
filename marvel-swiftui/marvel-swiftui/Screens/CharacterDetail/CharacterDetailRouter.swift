//
// CharacterDetailRouter.swift
// marvel-swiftui
//
// Copyright © 2023 Alex Morral. All rights reserved.
//

import UIKit

/// sourcery: AutoMockable
protocol CharacterDetailRouterProtocol {
    func dismiss()
}

class CharacterDetailRouter: CharacterDetailRouterProtocol {
    private weak var controller: CharacterDetailViewController?

    init(controller: CharacterDetailViewController) {
        self.controller = controller
    }

    func dismiss() {
        self.controller?.dismiss(animated: true, completion: nil)
    }
}
