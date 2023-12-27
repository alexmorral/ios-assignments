//
// CharacterListViewController.swift
// marvel-swiftui
//
// Copyright © 2023 Alex Morral. All rights reserved.
//

import UIKit
import SwiftUI

final class CharacterListViewController: UIViewController {

    var viewModel: CharacterListViewModel!

    private var hostingViewController: UIHostingController<CharacterListView>!
    private var rootView: CharacterListView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configureUI()
        viewModel.setup()
    }

    func setup() {
        rootView = CharacterListView(viewModel: viewModel)
        hostingViewController = UIHostingController(rootView: rootView)
        addChild(hostingViewController)
        view.addAndPin(view: hostingViewController.view)
    }

    func configureUI() {
        title = "Marvel Characters"
    }

}
