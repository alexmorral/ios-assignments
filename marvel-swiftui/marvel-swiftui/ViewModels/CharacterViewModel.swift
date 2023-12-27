//
//  CharacterViewModel.swift
//  marvel-swiftui
//
//  Created by Alex Morral on 13/10/23.
//

import Foundation

struct CharacterViewModel: Identifiable {
    private let apiCharacter: APICharacter

    init(apiCharacter: APICharacter) {
        self.apiCharacter = apiCharacter
    }

    var id: Int { apiCharacter.id }

    var name: String { apiCharacter.name }

    var thumbnail: String {
        "\(apiCharacter.thumbnail.path).\(apiCharacter.thumbnail.imageExtension)"
    }

    var comics: [ComicSummaryViewModel] {
        apiCharacter.comics.items.map({ ComicSummaryViewModel(apiComic: $0) })
    }
}

extension CharacterViewModel {
    static let fake: CharacterViewModel = {
        let character = CharacterViewModel(apiCharacter: .init(
            id: 1,
            name: "Name",
            thumbnail: .init(path: "jpg", imageExtension: "http://i.annihil.us/u/prod/marvel/i/mg/f/60/4c0042121d790"),
            comics: .init(items: []))
        )
        return character
    }()
}
