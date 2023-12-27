//
//  ComicSummaryViewModel.swift
//  marvel-swiftui
//
//  Created by Alex Morral on 13/10/23.
//

import Foundation

struct ComicSummaryViewModel: Identifiable {
    private let apiComic: APIComicSummary

    init(apiComic: APIComicSummary) {
        self.apiComic = apiComic
    }

    var id: String { name }

    var name: String { apiComic.name }

    var resourceURI: String { apiComic.resourceURI }
}
