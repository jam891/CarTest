//
//  CoreDataStack.swift
//  CarTest
//
//  Created by Vitaliy Delidov on 11/6/16.
//  Copyright © 2016 Vitaliy Delidov. All rights reserved.
//

import CoreData

class CoreDataStack {
    
    static var context: NSManagedObjectContext {
        return CoreDataStack.persistentContainer.viewContext
    }
    
    // MARK: - Core Data stack
    
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Database")
        container.loadPersistentStores(completionHandler: { storeDescription, error in
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    class func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("An error occurred while saving: \(error)")
            }
        }
    }
    
}

