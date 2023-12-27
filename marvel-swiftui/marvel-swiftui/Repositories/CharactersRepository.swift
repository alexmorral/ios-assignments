//
//  CharactersRepository.swift
//  marvel-swiftui
//
//  Created by Alex Morral on 13/10/23.
//

import Foundation

/// sourcery: AutoMockable
protocol CharactersRepositoryProtocol {
    func retrieveCharacters(
        offset: Int
    ) async throws -> APICharacterDataContainer
    func isCharacterFavorite(id: Int) -> Bool
    func markCharacterFavorite(id: Int) throws
    func unmarkCharacterFavorite(id: Int) throws
}

class CharactersRepository: CharactersRepositoryProtocol {
    let apiClient: APIClientProtocol
    let coreDataStack: CoreDataStackProtocol

    init(
        apiClient: APIClientProtocol = APIClient(),
        coreDataStack: CoreDataStackProtocol = CoreDataStack.shared
    ) {
        self.apiClient = apiClient
        self.coreDataStack = coreDataStack
    }

    func retrieveCharacters(
        offset: Int
    ) async throws -> APICharacterDataContainer {
        let decoder = JSONDecoder()

        let request = MarvelEndpoint.characters(offset: offset)
        let response: APICharacterDataWrapper = try await apiClient.performRequest(
            apiRequest: request,
            decoder: decoder
        )

        return response.data
    }

    func isCharacterFavorite(id: Int) -> Bool {
        let context = coreDataStack.mainContext

        let fetchRequest = CharacterFavorite.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "characterId = %i", id)

        let favorites = (try? context.fetch(fetchRequest)) ?? []

        return !favorites.isEmpty
    }

    func markCharacterFavorite(id: Int) throws {
        let context = coreDataStack.backgroundContext

        let characterFavorite = CharacterFavorite(context: context)
        characterFavorite.characterId = Int32(id)
        characterFavorite.timestamp = Date.now

        try context.save()
    }

    func unmarkCharacterFavorite(id: Int) throws {
        let context = coreDataStack.backgroundContext

        let fetchRequest = CharacterFavorite.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "characterId = %i", id)

        for item in try context.fetch(fetchRequest) {
            context.delete(item)
        }

        try context.save()
    }
}
