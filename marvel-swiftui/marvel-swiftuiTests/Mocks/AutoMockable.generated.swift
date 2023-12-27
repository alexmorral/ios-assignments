// Generated using Sourcery 2.1.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable line_length
// swiftlint:disable variable_name

import Foundation
#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif

import CoreData

@testable import marvel_swiftui






















class APIRequestMock: APIRequest {


    var baseURL: String {
        get { return underlyingBaseURL }
        set(value) { underlyingBaseURL = value }
    }
    var underlyingBaseURL: (String)!
    var path: String {
        get { return underlyingPath }
        set(value) { underlyingPath = value }
    }
    var underlyingPath: (String)!
    var httpMethod: String {
        get { return underlyingHttpMethod }
        set(value) { underlyingHttpMethod = value }
    }
    var underlyingHttpMethod: (String)!
    var httpHeaders: [String: String] = [:]
    var queryItems: [URLQueryItem] = []
    var httpBody: Data?


    //MARK: - buildRequest

    var buildRequestThrowableError: Error?
    var buildRequestCallsCount = 0
    var buildRequestCalled: Bool {
        return buildRequestCallsCount > 0
    }
    var buildRequestReturnValue: URLRequest!
    var buildRequestClosure: (() throws -> URLRequest)?

    func buildRequest() throws -> URLRequest {
        if let error = buildRequestThrowableError {
            throw error
        }
        buildRequestCallsCount += 1
        if let buildRequestClosure = buildRequestClosure {
            return try buildRequestClosure()
        } else {
            return buildRequestReturnValue
        }
    }

}
class CharacterDetailConfiguratorProtocolMock: CharacterDetailConfiguratorProtocol {




    //MARK: - configure

    var configureControllerCharacterCallsCount = 0
    var configureControllerCharacterCalled: Bool {
        return configureControllerCharacterCallsCount > 0
    }
    var configureControllerCharacterReceivedArguments: (controller: CharacterDetailViewController, character: CharacterViewModel)?
    var configureControllerCharacterReceivedInvocations: [(controller: CharacterDetailViewController, character: CharacterViewModel)] = []
    var configureControllerCharacterClosure: ((CharacterDetailViewController, CharacterViewModel) -> Void)?

    func configure(controller: CharacterDetailViewController, character: CharacterViewModel) {
        configureControllerCharacterCallsCount += 1
        configureControllerCharacterReceivedArguments = (controller: controller, character: character)
        configureControllerCharacterReceivedInvocations.append((controller: controller, character: character))
        configureControllerCharacterClosure?(controller, character)
    }

}
class CharacterDetailRouterProtocolMock: CharacterDetailRouterProtocol {




    //MARK: - dismiss

    var dismissCallsCount = 0
    var dismissCalled: Bool {
        return dismissCallsCount > 0
    }
    var dismissClosure: (() -> Void)?

    func dismiss() {
        dismissCallsCount += 1
        dismissClosure?()
    }

}
class CharacterDetailViewModelProtocolMock: CharacterDetailViewModelProtocol {




}
class CharacterListConfiguratorProtocolMock: CharacterListConfiguratorProtocol {




    //MARK: - configure

    var configureControllerCallsCount = 0
    var configureControllerCalled: Bool {
        return configureControllerCallsCount > 0
    }
    var configureControllerReceivedController: (CharacterListViewController)?
    var configureControllerReceivedInvocations: [(CharacterListViewController)] = []
    var configureControllerClosure: ((CharacterListViewController) -> Void)?

    func configure(controller: CharacterListViewController) {
        configureControllerCallsCount += 1
        configureControllerReceivedController = controller
        configureControllerReceivedInvocations.append(controller)
        configureControllerClosure?(controller)
    }

}
class CharacterListRouterProtocolMock: CharacterListRouterProtocol {




    //MARK: - presentCharacterDetail

    var presentCharacterDetailCharacterCallsCount = 0
    var presentCharacterDetailCharacterCalled: Bool {
        return presentCharacterDetailCharacterCallsCount > 0
    }
    var presentCharacterDetailCharacterReceivedCharacter: (CharacterViewModel)?
    var presentCharacterDetailCharacterReceivedInvocations: [(CharacterViewModel)] = []
    var presentCharacterDetailCharacterClosure: ((CharacterViewModel) -> Void)?

    func presentCharacterDetail(character: CharacterViewModel) {
        presentCharacterDetailCharacterCallsCount += 1
        presentCharacterDetailCharacterReceivedCharacter = character
        presentCharacterDetailCharacterReceivedInvocations.append(character)
        presentCharacterDetailCharacterClosure?(character)
    }

    //MARK: - dismiss

    var dismissCallsCount = 0
    var dismissCalled: Bool {
        return dismissCallsCount > 0
    }
    var dismissClosure: (() -> Void)?

    func dismiss() {
        dismissCallsCount += 1
        dismissClosure?()
    }

}
class CharacterListViewModelProtocolMock: CharacterListViewModelProtocol {




}
class CharactersRepositoryProtocolMock: CharactersRepositoryProtocol {




    //MARK: - retrieveCharacters

    var retrieveCharactersOffsetThrowableError: Error?
    var retrieveCharactersOffsetCallsCount = 0
    var retrieveCharactersOffsetCalled: Bool {
        return retrieveCharactersOffsetCallsCount > 0
    }
    var retrieveCharactersOffsetReceivedOffset: (Int)?
    var retrieveCharactersOffsetReceivedInvocations: [(Int)] = []
    var retrieveCharactersOffsetReturnValue: APICharacterDataContainer!
    var retrieveCharactersOffsetClosure: ((Int) async throws -> APICharacterDataContainer)?

    func retrieveCharacters(offset: Int) async throws -> APICharacterDataContainer {
        if let error = retrieveCharactersOffsetThrowableError {
            throw error
        }
        retrieveCharactersOffsetCallsCount += 1
        retrieveCharactersOffsetReceivedOffset = offset
        retrieveCharactersOffsetReceivedInvocations.append(offset)
        if let retrieveCharactersOffsetClosure = retrieveCharactersOffsetClosure {
            return try await retrieveCharactersOffsetClosure(offset)
        } else {
            return retrieveCharactersOffsetReturnValue
        }
    }

    //MARK: - isCharacterFavorite

    var isCharacterFavoriteIdCallsCount = 0
    var isCharacterFavoriteIdCalled: Bool {
        return isCharacterFavoriteIdCallsCount > 0
    }
    var isCharacterFavoriteIdReceivedId: (Int)?
    var isCharacterFavoriteIdReceivedInvocations: [(Int)] = []
    var isCharacterFavoriteIdReturnValue: Bool!
    var isCharacterFavoriteIdClosure: ((Int) -> Bool)?

    func isCharacterFavorite(id: Int) -> Bool {
        isCharacterFavoriteIdCallsCount += 1
        isCharacterFavoriteIdReceivedId = id
        isCharacterFavoriteIdReceivedInvocations.append(id)
        if let isCharacterFavoriteIdClosure = isCharacterFavoriteIdClosure {
            return isCharacterFavoriteIdClosure(id)
        } else {
            return isCharacterFavoriteIdReturnValue
        }
    }

    //MARK: - markCharacterFavorite

    var markCharacterFavoriteIdThrowableError: Error?
    var markCharacterFavoriteIdCallsCount = 0
    var markCharacterFavoriteIdCalled: Bool {
        return markCharacterFavoriteIdCallsCount > 0
    }
    var markCharacterFavoriteIdReceivedId: (Int)?
    var markCharacterFavoriteIdReceivedInvocations: [(Int)] = []
    var markCharacterFavoriteIdClosure: ((Int) throws -> Void)?

    func markCharacterFavorite(id: Int) throws {
        if let error = markCharacterFavoriteIdThrowableError {
            throw error
        }
        markCharacterFavoriteIdCallsCount += 1
        markCharacterFavoriteIdReceivedId = id
        markCharacterFavoriteIdReceivedInvocations.append(id)
        try markCharacterFavoriteIdClosure?(id)
    }

    //MARK: - unmarkCharacterFavorite

    var unmarkCharacterFavoriteIdThrowableError: Error?
    var unmarkCharacterFavoriteIdCallsCount = 0
    var unmarkCharacterFavoriteIdCalled: Bool {
        return unmarkCharacterFavoriteIdCallsCount > 0
    }
    var unmarkCharacterFavoriteIdReceivedId: (Int)?
    var unmarkCharacterFavoriteIdReceivedInvocations: [(Int)] = []
    var unmarkCharacterFavoriteIdClosure: ((Int) throws -> Void)?

    func unmarkCharacterFavorite(id: Int) throws {
        if let error = unmarkCharacterFavoriteIdThrowableError {
            throw error
        }
        unmarkCharacterFavoriteIdCallsCount += 1
        unmarkCharacterFavoriteIdReceivedId = id
        unmarkCharacterFavoriteIdReceivedInvocations.append(id)
        try unmarkCharacterFavoriteIdClosure?(id)
    }

}
class CoreDataStackProtocolMock: CoreDataStackProtocol {


    var mainContext: NSManagedObjectContext {
        get { return underlyingMainContext }
        set(value) { underlyingMainContext = value }
    }
    var underlyingMainContext: (NSManagedObjectContext)!
    var backgroundContext: NSManagedObjectContext {
        get { return underlyingBackgroundContext }
        set(value) { underlyingBackgroundContext = value }
    }
    var underlyingBackgroundContext: (NSManagedObjectContext)!


    //MARK: - save

    var saveContextThrowableError: Error?
    var saveContextCallsCount = 0
    var saveContextCalled: Bool {
        return saveContextCallsCount > 0
    }
    var saveContextReceivedContext: (NSManagedObjectContext)?
    var saveContextReceivedInvocations: [(NSManagedObjectContext)] = []
    var saveContextClosure: ((NSManagedObjectContext) throws -> Void)?

    func save(context: NSManagedObjectContext) throws {
        if let error = saveContextThrowableError {
            throw error
        }
        saveContextCallsCount += 1
        saveContextReceivedContext = context
        saveContextReceivedInvocations.append(context)
        try saveContextClosure?(context)
    }

    //MARK: - delete

    var deleteObjectContextCallsCount = 0
    var deleteObjectContextCalled: Bool {
        return deleteObjectContextCallsCount > 0
    }
    var deleteObjectContextReceivedArguments: (object: NSManagedObject, context: NSManagedObjectContext)?
    var deleteObjectContextReceivedInvocations: [(object: NSManagedObject, context: NSManagedObjectContext)] = []
    var deleteObjectContextClosure: ((NSManagedObject, NSManagedObjectContext) -> Void)?

    func delete(object: NSManagedObject, context: NSManagedObjectContext) {
        deleteObjectContextCallsCount += 1
        deleteObjectContextReceivedArguments = (object: object, context: context)
        deleteObjectContextReceivedInvocations.append((object: object, context: context))
        deleteObjectContextClosure?(object, context)
    }

}
class SplashConfiguratorProtocolMock: SplashConfiguratorProtocol {




    //MARK: - configure

    var configureControllerCallsCount = 0
    var configureControllerCalled: Bool {
        return configureControllerCallsCount > 0
    }
    var configureControllerReceivedController: (SplashViewController)?
    var configureControllerReceivedInvocations: [(SplashViewController)] = []
    var configureControllerClosure: ((SplashViewController) -> Void)?

    func configure(controller: SplashViewController) {
        configureControllerCallsCount += 1
        configureControllerReceivedController = controller
        configureControllerReceivedInvocations.append(controller)
        configureControllerClosure?(controller)
    }

}
class SplashRouterProtocolMock: SplashRouterProtocol {




    //MARK: - presentCharacterList

    var presentCharacterListCallsCount = 0
    var presentCharacterListCalled: Bool {
        return presentCharacterListCallsCount > 0
    }
    var presentCharacterListClosure: (() -> Void)?

    func presentCharacterList() {
        presentCharacterListCallsCount += 1
        presentCharacterListClosure?()
    }

    //MARK: - dismiss

    var dismissCallsCount = 0
    var dismissCalled: Bool {
        return dismissCallsCount > 0
    }
    var dismissClosure: (() -> Void)?

    func dismiss() {
        dismissCallsCount += 1
        dismissClosure?()
    }

}
class SplashViewModelProtocolMock: SplashViewModelProtocol {




}
