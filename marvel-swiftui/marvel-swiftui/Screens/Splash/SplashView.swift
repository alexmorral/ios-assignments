//
// SplashView.swift
// marvel-swiftui
//
// Copyright © 2023 Alex Morral. All rights reserved.
//

import SwiftUI

struct SplashView: View {
    @ObservedObject var viewModel: SplashViewModel

    var body: some View {
        Color.white
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel: SplashViewModel = {
            let vc = SplashViewController()
            let configurator = SplashConfigurator()
            configurator.configure(controller: vc)
            return vc.viewModel
        }()
        SplashView(viewModel: viewModel)
    }
}
