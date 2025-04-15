//
//  CoreDataManager.swift
//  CurrencyCalculator0414
//
//  Created by tlswo on 4/15/25.
//

import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "CurrencyCalculator0414")
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Core Data Load Error: \(error)")
            }
        }
    }
}
