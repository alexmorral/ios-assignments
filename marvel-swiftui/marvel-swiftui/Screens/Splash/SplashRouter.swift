//
// SplashRouter.swift
// marvel-swiftui
//
// Copyright © 2023 Alex Morral. All rights reserved.
//

import UIKit

/// sourcery: AutoMockable
protocol SplashRouterProtocol {
    func presentCharacterList()
    func dismiss()
}

class SplashRouter: SplashRouterProtocol {
    private weak var controller: SplashViewController?

    init(controller: SplashViewController) {
        self.controller = controller
    }

    func presentCharacterList() {
        let viewController = CharacterListViewController()
        let configurator = CharacterListConfigurator()
        configurator.configure(controller: viewController)

        let navViewController = UINavigationController(rootViewController: viewController)
        navViewController.modalPresentationStyle = .fullScreen
        navViewController.modalTransitionStyle = .crossDissolve

        controller?.present(navViewController, animated: true)
    }

    func dismiss() {
        self.controller?.dismiss(animated: true, completion: nil)
    }
}
