//
//  CharactersRepositoryTests.swift
//  marvel-swiftuiTests
//
//  Created by Alex Morral on 14/10/23.
//

import XCTest
@testable import marvel_swiftui

final class CharactersRepositoryTests: XCTestCase {

    var sut: CharactersRepository!
    var apiClient: APIClientProtocolMock!
    var coreDataStack: CoreDataStackProtocolMock!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        apiClient = APIClientProtocolMock()
        coreDataStack = CoreDataStackProtocolMock()

        sut = CharactersRepository(
            apiClient: apiClient,
            coreDataStack: coreDataStack
        )
    }

    func testRetrieveCharacters() async throws {
        let apiCharacter = APICharacter(
            id: 123,
            name: "name",
            thumbnail: .init(path: "", imageExtension: ""),
            comics: .init(items: [])
        )

        apiClient.performRequestApiRequestDecoderReturnValue = APICharacterDataWrapper(
            code: 200,
            data: .init(
                offset: 0,
                limit: 1,
                total: 1,
                count: 1,
                results: [apiCharacter]
            )
        )
        let response = try await sut.retrieveCharacters(offset: 0)

        XCTAssertTrue(apiClient.performRequestApiRequestDecoderCalled)
        XCTAssert(response.results.first?.id == apiCharacter.id)
        XCTAssert(apiClient.performRequestApiRequestDecoderCallsCount == 1)
    }

}
