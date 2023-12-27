//
// TVShowListRouter.swift
// TMDB-Assignment
//
// Copyright © 2023 Alex Morral. All rights reserved.
//

import UIKit

/// sourcery: AutoMockable
protocol TVShowListRouterProtocol {
    func dismiss()
}

class TVShowListRouter: TVShowListRouterProtocol {
    private weak var controller: TVShowListViewController?

    init(controller: TVShowListViewController) {
        self.controller = controller
    }

    func dismiss() {
        self.controller?.dismiss(animated: true, completion: nil)
    }
}
