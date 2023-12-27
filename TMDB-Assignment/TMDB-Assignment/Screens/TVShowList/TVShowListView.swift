//
// TVShowListView.swift
// TMDB-Assignment
//
// Copyright © 2023 Alex Morral. All rights reserved.
//

import SwiftUI
import Kingfisher

struct TVShowListView: View {
    @ObservedObject var viewModel: TVShowListViewModel

    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        ScrollView {
            VStack {
                genresView
                tvShowsView
            }
            .padding(.horizontal)
        }
        .refreshable {
            await viewModel.loadGenres()
        }
    }

    @ViewBuilder
    private var genresView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(viewModel.tvGenres) { genre in
                    Button(action: { viewModel.selectedGenre = genre }) {
                        Text(genre.name)
                            .foregroundColor(genre == viewModel.selectedGenre ? Color.white : Color.black)
                            .padding(.vertical, 6)
                            .padding(.horizontal, 8)
                            .background(
                                genre == viewModel.selectedGenre ? Color.genreSelectedBackground : Color.genreUnselectedBackground
                            )
                            .cornerRadius(12)
                    }
                }
            }
        }
    }

    @ViewBuilder
    private var tvShowsView: some View {
        LazyVGrid(columns: columns) {
            ForEach(Array(zip(viewModel.tvShows.indices, viewModel.tvShows)), id: \.0) { index, tvShow in
                VStack {
                    if let imageURL = tvShow.imageURL {
                        KFImage(imageURL)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50)
                    }
                    Text("Name: \(tvShow.name)")
                    Text("Rating: \(tvShow.rating)")
                    if let lastAirDate = tvShow.lastAirDate {
                        Text("Last Air Date: \(lastAirDate)")
                    }
                    if let lastEpisodeToAir = tvShow.lastEpisodeToAir {
                        Text("LastEpisodeToAir: \(lastEpisodeToAir.name)")
                    }
                }
                .padding()
                .frame(height: 250)
                .frame(maxWidth: .infinity)
                .border(Color.gray, width: 1)
                .onAppear {
                    if index == viewModel.tvShows.count - 1 {
                        viewModel.loadNextTVShowsPage()
                    }
                }
            }
        }
    }
}

struct TVShowListView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel: TVShowListViewModel = {
            let viewController = TVShowListViewController()
            let configurator = TVShowListConfigurator()
            configurator.configure(viewController)
            return viewController.viewModel
        }()
        TVShowListView(viewModel: viewModel)
    }
}
