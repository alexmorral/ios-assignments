//
// CharacterListView.swift
// marvel-swiftui
//
// Copyright © 2023 Alex Morral. All rights reserved.
//

import SwiftUI
import Kingfisher

struct CharacterListView: View {
    @ObservedObject var viewModel: CharacterListViewModel

    var body: some View {
        switch viewModel.viewState {
        case .idle, .errorLoadingPage, .loadingNextPage:
            characterList
        case .loading:
            ProgressView()
        case .error:
            VStack {
                Text("Something went wrong. Please try again")
                Button(action: viewModel.setup) {
                    Text("Try again")
                }
            }
        }
    }

    @ViewBuilder
    var characterList: some View {
        List {
            ForEach(viewModel.characters) { character in
                characterCell(character: character)
            }
            listFooter
        }
    }

    @ViewBuilder
    func characterCell(character: CharacterViewModel) -> some View {
        Button(action: { viewModel.characterTapped(character: character) }) {
            HStack {
                KFImage
                    .url(URL(string: character.thumbnail))
                    .placeholder {
                        ProgressView()
                    }
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 40, maxHeight: 40)
                Text(character.name)
                    .foregroundColor(.primary)
            }
        }
    }

    @ViewBuilder
    var listFooter: some View {
        Section {
            EmptyView()
        } footer: {
            if viewModel.viewState == .errorLoadingPage {
                nextPageError
            } else if !viewModel.listFullyLoaded {
                nextPageLoader
            }
        }
    }

    @ViewBuilder
    var nextPageError: some View {
        HStack {
            Spacer()
            VStack {
                Text("Loading list failed")
                Button(action: viewModel.loadNextPageData) {
                    Text("Try again")
                }
            }
            Spacer()
        }
    }

    @ViewBuilder
    var nextPageLoader: some View {
        HStack {
            Spacer()
            ProgressView()
            Spacer()
        }
        .onAppear {
            if viewModel.viewState != .loadingNextPage {
                viewModel.loadNextPageData()
            }
        }
    }
}

struct CharacterListView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel: CharacterListViewModel = {
            let vc = CharacterListViewController()
            let configurator = CharacterListConfigurator()
            configurator.configure(controller: vc)
            return vc.viewModel
        }()
        CharacterListView(viewModel: viewModel)
    }
}
