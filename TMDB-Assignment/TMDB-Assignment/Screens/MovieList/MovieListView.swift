//
// MovieListView.swift
// TMDB-Assignment
//
// Copyright © 2023 Alex Morral. All rights reserved.
//

import SwiftUI
import Kingfisher

struct MovieListView: View {
    @ObservedObject var viewModel: MovieListViewModel

    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        ScrollView {
            VStack {
                genresView
                moviesView
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
                ForEach(viewModel.movieGenres) { genre in
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
    private var moviesView: some View {
        LazyVGrid(columns: columns) {
            ForEach(Array(zip(viewModel.movies.indices, viewModel.movies)), id: \.0) { index, movie in
                VStack {
                    if let imageURL = movie.imageURL {
                        KFImage(imageURL)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50)
                    }
                    Text("Title: \(movie.title)")
                    Text("Rating: \(movie.rating)")
                    if let budget = movie.budget {
                        Text("Budget: \(budget)")
                    }
                    if let revenue = movie.revenue {
                        Text("Revenue: \(revenue)")
                    }
                }
                .padding()
                .frame(height: 250)
                .frame(maxWidth: .infinity)
                .border(Color.gray, width: 1)
                .onAppear {
                    if index == viewModel.movies.count - 1 {
                        viewModel.loadNextMoviesPage()
                    }
                }
            }
        }
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel: MovieListViewModel = {
            let viewController = MovieListViewController()
            let configurator = MovieListConfigurator()
            configurator.configure(viewController)
            return viewController.viewModel
        }()
        MovieListView(viewModel: viewModel)
    }
}
