//
//  CoreDataStack.swift
// marvel-swiftui
//
// Copyright © 2023 Alex Morral. All rights reserved.
//

import Foundation
import CoreData

/// sourcery: AutoMockable
protocol CoreDataStackProtocol {
    var mainContext: NSManagedObjectContext { get }
    var backgroundContext: NSManagedObjectContext { get }

    func save(context: NSManagedObjectContext) throws
    func delete(object: NSManagedObject, context: NSManagedObjectContext)
}

class CoreDataStack: NSObject, CoreDataStackProtocol {
    override init() {}

    static let shared = CoreDataStack()

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "marvel-swiftui")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            logger.info("Store location: \(String(describing: storeDescription.url))")
            container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    var mainContext: NSManagedObjectContext {
        let context = persistentContainer.viewContext
        context.automaticallyMergesChangesFromParent = true
        return context
    }

    var backgroundContext: NSManagedObjectContext {
        let context = persistentContainer.newBackgroundContext()
        context.automaticallyMergesChangesFromParent = true
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return context
    }

    func save(context: NSManagedObjectContext) throws {
        context.performAndWait {
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    logger.error(error)
                }
            }
        }
    }

    func delete(object: NSManagedObject, context: NSManagedObjectContext) {
        context.performAndWait {
            context.delete(object)
        }
    }
}
