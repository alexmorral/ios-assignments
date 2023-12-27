//
// CharacterDetailViewModel.swift
// marvel-swiftui
//
// Copyright © 2023 Alex Morral. All rights reserved.
//

import UIKit
import SwiftUI

/// sourcery: AutoMockable
protocol CharacterDetailViewModelProtocol {

}

final class CharacterDetailViewModel: CharacterDetailViewModelProtocol, ObservableObject {
    private let router: CharacterDetailRouterProtocol
    private let charactersRepository: CharactersRepositoryProtocol

    let character: CharacterViewModel
    @Published var isCharacterFavorite: Bool = false

    init(
        router: CharacterDetailRouterProtocol,
        charactersRepository: CharactersRepositoryProtocol,
        character: CharacterViewModel
    ) {
        self.router = router
        self.charactersRepository = charactersRepository
        self.character = character
    }

    func setup() {
        isCharacterFavorite = charactersRepository.isCharacterFavorite(id: character.id)
    }

    func toggleCharacterFavorite() {
        do {
            if isCharacterFavorite {
                try charactersRepository.unmarkCharacterFavorite(id: character.id)
                isCharacterFavorite = false
            } else {
                try charactersRepository.markCharacterFavorite(id: character.id)
                isCharacterFavorite = true
            }
        } catch {
            logger.error(error.localizedDescription)
        }
    }
}
