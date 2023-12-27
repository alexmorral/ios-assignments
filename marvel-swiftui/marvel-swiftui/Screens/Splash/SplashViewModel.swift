//
// SplashViewModel.swift
// marvel-swiftui
//
// Copyright © 2023 Alex Morral. All rights reserved.
//

import UIKit
import SwiftUI

/// sourcery: AutoMockable
protocol SplashViewModelProtocol {

}

final class SplashViewModel: SplashViewModelProtocol, ObservableObject {
    private let router: SplashRouterProtocol

    init(router: SplashRouterProtocol) {
        self.router = router
    }

    func setup() {
        router.presentCharacterList()
    }
}
