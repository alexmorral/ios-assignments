//
// MovieListRouter.swift
// TMDB-Assignment
//
// Copyright © 2023 Alex Morral. All rights reserved.
//

import UIKit

/// sourcery: AutoMockable
protocol MovieListRouterProtocol {
    func dismiss()
}

class MovieListRouter: MovieListRouterProtocol {
    private weak var controller: MovieListViewController?

    init(controller: MovieListViewController) {
        self.controller = controller
    }

    func dismiss() {
        self.controller?.dismiss(animated: true, completion: nil)
    }
}
