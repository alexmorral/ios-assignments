//
// SplashConfigurator.swift
// marvel-swiftui
//
// Copyright © 2023 Alex Morral. All rights reserved.
//

import UIKit

/// sourcery: AutoMockable
protocol SplashConfiguratorProtocol {
    func configure(controller: SplashViewController)
}

struct SplashConfigurator: SplashConfiguratorProtocol {
    func configure(controller: SplashViewController) {
        let router = SplashRouter(controller: controller)
        let viewModel = SplashViewModel(router: router)

        controller.viewModel = viewModel
    }
}
