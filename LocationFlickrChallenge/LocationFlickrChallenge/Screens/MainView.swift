//
//  MainView.swift
//  LocationFlickrChallenge
//
//  Created by Alex Morral on 31/10/22.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                contentView
            }
            .navigationTitle("Main")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: viewModel.toggleLocationUpdates) {
                        Text(viewModel.locationState == .stopped ? "Start" : "Stop")
                    }
                }
            }
        }
    }

    @ViewBuilder
    var contentView: some View {
        switch viewModel.viewState {
        case .idle:
            imageList
        case .error(let errorString):
            Text(errorString)
        }
    }

    @ViewBuilder
    var imageList: some View {
        if viewModel.images.isEmpty {
            if viewModel.locationState == .locating {
                Text("Location Started: Waiting for first image")
            } else {
                Text("Press the button to start")
            }
        } else {
            LazyVStack {
                ForEach(viewModel.images) { image in
                    AsyncImage(url: image.url) { img in
                        img.resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        Text("Loading")
                    }
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
