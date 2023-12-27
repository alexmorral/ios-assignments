//
// TVShowListViewController.swift
// TMDB-Assignment
//
// Copyright © 2023 Alex Morral. All rights reserved.
//

import UIKit
import SwiftUI

final class TVShowListViewController: UIViewController {

    var viewModel: TVShowListViewModel!

    private var hostingViewController: UIHostingController<TVShowListView>!
    private var rootView: TVShowListView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configureUI()
        viewModel.setup()
    }

    func setup() {
        rootView = TVShowListView(viewModel: viewModel)
        hostingViewController = UIHostingController(rootView: rootView)
        addChild(hostingViewController)
        view.addAndPin(view: hostingViewController.view)
    }

    func configureUI() {
        navigationItem.title = "TV Shows"
    }
}
