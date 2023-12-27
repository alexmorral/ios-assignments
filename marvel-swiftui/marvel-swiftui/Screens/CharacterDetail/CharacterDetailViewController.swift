//
// CharacterDetailViewController.swift
// marvel-swiftui
//
// Copyright © 2023 Alex Morral. All rights reserved.
//

import UIKit
import SwiftUI

final class CharacterDetailViewController: UIViewController {

    var viewModel: CharacterDetailViewModel!

    private var hostingViewController: UIHostingController<CharacterDetailView>!
    private var rootView: CharacterDetailView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configureUI()
        viewModel.setup()
    }

    func setup() {
        rootView = CharacterDetailView(viewModel: viewModel)
        hostingViewController = UIHostingController(rootView: rootView)
        addChild(hostingViewController)
        view.addAndPin(view: hostingViewController.view)
    }

    func configureUI() {

    }

}
