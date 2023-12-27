//
// MovieListViewController.swift
// TMDB-Assignment
//
// Copyright © 2023 Alex Morral. All rights reserved.
//

import UIKit
import SwiftUI

final class MovieListViewController: UIViewController {

    var viewModel: MovieListViewModel!

    private var hostingViewController: UIHostingController<MovieListView>!
    private var rootView: MovieListView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configureUI()
        viewModel.setup()
    }

    func setup() {
        rootView = MovieListView(viewModel: viewModel)
        hostingViewController = UIHostingController(rootView: rootView)
        addChild(hostingViewController)
        view.addAndPin(view: hostingViewController.view)
    }

    func configureUI() {
        navigationItem.title = "Movies"
    }

}
