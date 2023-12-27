//
// SplashViewController.swift
// marvel-swiftui
//
// Copyright © 2023 Alex Morral. All rights reserved.
//

import UIKit
import SwiftUI

final class SplashViewController: UIViewController {

    var viewModel: SplashViewModel!

    private var hostingViewController: UIHostingController<SplashView>!
    private var rootView: SplashView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    func setup() {
        rootView = SplashView(viewModel: viewModel)
        hostingViewController = UIHostingController(rootView: rootView)
        addChild(hostingViewController)
        view.addAndPin(view: hostingViewController.view)
    }

    override func viewDidAppear(_ animated: Bool) {
        viewModel.setup()
    }
}
