//
//  CharacterListViewModelTests.swift
//  marvel-swiftuiTests
//
//  Created by Alex Morral on 14/10/23.
//

import XCTest
@testable import marvel_swiftui

final class CharacterListViewModelTests: XCTestCase {

    var sut: CharacterListViewModel!
    var router: CharacterListRouterProtocolMock!
    var charactersRepository: CharactersRepositoryProtocolMock!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        router = CharacterListRouterProtocolMock()
        charactersRepository = CharactersRepositoryProtocolMock()

        sut = CharacterListViewModel(
            router: router,
            charactersRepository: charactersRepository
        )
    }

    var apiCharacters: [APICharacter] {
        [
            .init(id: 1, name: "One", thumbnail: .init(path: "", imageExtension: ""), comics: .init(items: [])),
            .init(id: 2, name: "Two", thumbnail: .init(path: "", imageExtension: ""), comics: .init(items: [])),
            .init(id: 3, name: "Three", thumbnail: .init(path: "", imageExtension: ""), comics: .init(items: [])),
            .init(id: 4, name: "Four", thumbnail: .init(path: "", imageExtension: ""), comics: .init(items: []))
        ]
    }

    func testLoadDataNotFull() async throws {
        charactersRepository.retrieveCharactersOffsetReturnValue = .init(
            offset: 0,
            limit: 2,
            total: 10,
            count: 2,
            results: apiCharacters
        )

        await sut.loadData()
        
        XCTAssert(sut.characters.count == apiCharacters.count)
        XCTAssert(sut.currentOffset == apiCharacters.count)
        XCTAssertFalse(sut.listFullyLoaded)
    }

    func testLoadDataFull() async throws {
        charactersRepository.retrieveCharactersOffsetReturnValue = .init(
            offset: 0,
            limit: 2,
            total: apiCharacters.count,
            count: 2,
            results: apiCharacters
        )

        await sut.loadData()

        XCTAssert(sut.characters.count == apiCharacters.count)
        XCTAssert(sut.currentOffset == apiCharacters.count)
        XCTAssertTrue(sut.listFullyLoaded)
    }

    func testLoadNextPage() async throws {
        let apiCharactersFirstPage = Array(apiCharacters[0...1])
        charactersRepository.retrieveCharactersOffsetReturnValue = .init(
            offset: 0,
            limit: 2,
            total: 4,
            count: 2,
            results: apiCharactersFirstPage
        )
        await sut.loadData()

        let apiCharactersSecondPage = Array(apiCharacters[2...3])
        charactersRepository.retrieveCharactersOffsetReturnValue = .init(
            offset: 0,
            limit: 2,
            total: 4,
            count: 2,
            results: apiCharactersSecondPage
        )

        await sut.loadData(refresh: false)

        XCTAssert(sut.characters.count == apiCharacters.count)
        XCTAssert(sut.currentOffset == apiCharacters.count)
        XCTAssertTrue(sut.listFullyLoaded)
    }

    func testTapCharacterRouterCalled() throws {
        let characterViewModel = CharacterViewModel(apiCharacter:
                apiCharacters[0]
        )

        sut.characterTapped(character: characterViewModel)
        XCTAssertTrue(router.presentCharacterDetailCharacterCalled)
    }

}
