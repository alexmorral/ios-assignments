//
// CharacterDetailView.swift
// marvel-swiftui
//
// Copyright © 2023 Alex Morral. All rights reserved.
//

import SwiftUI
import Kingfisher

struct CharacterDetailView: View {
    @ObservedObject var viewModel: CharacterDetailViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                headerSection
                comicsSection
                    .padding(.horizontal)
            }
        }
    }

    @ViewBuilder
    var headerSection: some View {
        KFImage
            .url(URL(string: viewModel.character.thumbnail))
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: .infinity)
            .overlay {
                VStack {
                    HStack {
                        Spacer()
                        favoriteButton
                            .padding()
                    }
                    Spacer()
                }
            }

        Text(viewModel.character.name)
            .font(.title)
            .padding(.horizontal)
    }

    @ViewBuilder
    var comicsSection: some View {
        Divider()
        Text("Comic list")
        VStack {
            ForEach(viewModel.character.comics) { comicSummary in
                Text(comicSummary.name)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
                    .background(Color(white: 0.9))
                    .cornerRadius(12)
            }
        }
    }

    @ViewBuilder
    var favoriteButton: some View {
        Button(action: viewModel.toggleCharacterFavorite) {
            Image(systemName: viewModel.isCharacterFavorite ? "heart.fill" : "heart")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25)
                .padding(12)
                .foregroundColor(.pink)
                .background(.white)
                .clipShape(.capsule)
        }
    }

}

struct CharacterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel: CharacterDetailViewModel = {
            let vc = CharacterDetailViewController()
            let configurator = CharacterDetailConfigurator()
            configurator.configure(
                controller: vc,
                character: .fake
            )
            return vc.viewModel
        }()
        CharacterDetailView(viewModel: viewModel)
    }
}
