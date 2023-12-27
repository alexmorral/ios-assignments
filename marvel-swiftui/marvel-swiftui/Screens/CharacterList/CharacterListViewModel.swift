//
// CharacterListViewModel.swift
// marvel-swiftui
//
// Copyright © 2023 Alex Morral. All rights reserved.
//

import UIKit
import SwiftUI

/// sourcery: AutoMockable
protocol CharacterListViewModelProtocol {

}

final class CharacterListViewModel: CharacterListViewModelProtocol, ObservableObject {
    private let router: CharacterListRouterProtocol
    private let charactersRepository: CharactersRepositoryProtocol
    @Published var viewState: ViewState = .idle

    @Published var characters: [CharacterViewModel] = []
    @Published var listFullyLoaded = false
    var currentOffset = 0

    enum ViewState {
        case idle
        case loading
        case loadingNextPage
        case error
        case errorLoadingPage
    }

    init(
        router: CharacterListRouterProtocol,
        charactersRepository: CharactersRepositoryProtocol
    ) {
        self.router = router
        self.charactersRepository = charactersRepository
    }

    func setup() {
        Task { @MainActor in
            await loadData()
        }
    }

    func loadNextPageData() {
        Task { @MainActor in
            await loadData(refresh: false)
        }
    }

    @MainActor
    func loadData(refresh: Bool = true) async {
        do {
            if refresh {
                viewState = .loading
                currentOffset = 0
            } else {
                viewState = .loadingNextPage
            }
            logger.info("Loading characters with offset \(currentOffset)")
            let characterData = try await charactersRepository.retrieveCharacters(offset: currentOffset)
            if refresh {
                characters = characterData.results.map({ CharacterViewModel(apiCharacter: $0) })
            } else {
                characters.append(contentsOf: characterData.results.map({ CharacterViewModel(apiCharacter: $0) }))
            }
            logger.info("Characters loaded successfully")
            currentOffset = characters.count
            listFullyLoaded = characters.count == characterData.total
            viewState = .idle
        } catch {
            error.printCatchError()
            viewState = refresh ? .error : .errorLoadingPage
        }
    }

    func characterTapped(character: CharacterViewModel) {
        router.presentCharacterDetail(character: character)
    }
}
