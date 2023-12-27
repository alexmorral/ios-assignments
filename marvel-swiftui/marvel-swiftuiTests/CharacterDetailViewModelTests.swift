//
//  CharacterDetailViewModelTests.swift
//  marvel-swiftuiTests
//
//  Created by Alex Morral on 14/10/23.
//

import XCTest
@testable import marvel_swiftui

final class CharacterDetailViewModelTests: XCTestCase {

    var sut: CharacterDetailViewModel!
    var router: CharacterDetailRouterProtocolMock!
    var charactersRepository: CharactersRepositoryProtocolMock!
    var characterViewModel: CharacterViewModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        router = CharacterDetailRouterProtocolMock()
        charactersRepository = CharactersRepositoryProtocolMock()

        characterViewModel = .init(apiCharacter: .init(
            id: 1,
            name: "One",
            thumbnail: .init(path: "", imageExtension: ""),
            comics: .init(items: [])
        ))

        sut = CharacterDetailViewModel(
            router: router,
            charactersRepository: charactersRepository, 
            character: characterViewModel
        )
    }

    func testMarkFavorite() throws {
        charactersRepository.isCharacterFavoriteIdReturnValue = false
        sut.setup()

        sut.toggleCharacterFavorite()

        XCTAssertTrue(sut.isCharacterFavorite)
        XCTAssertTrue(charactersRepository.markCharacterFavoriteIdCalled)
    }

    func testUnmarkFavorite() throws {
        charactersRepository.isCharacterFavoriteIdReturnValue = true
        sut.setup()

        sut.toggleCharacterFavorite()

        XCTAssertFalse(sut.isCharacterFavorite)
        XCTAssertTrue(charactersRepository.unmarkCharacterFavoriteIdCalled)
    }

}
