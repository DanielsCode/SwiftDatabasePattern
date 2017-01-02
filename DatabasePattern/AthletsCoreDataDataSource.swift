//
//  AthletsCoreDataDataSource.swift
//  DatabasePattern
//
//  Created by Daniel Siegel on 28.12.16.
//  Copyright © 2016 Daniel Siegel. All rights reserved.
//

import Foundation
import CoreData

class AthletsCoreDataDataSource: DataSource {
    
    private let coreDataStack = CoreDataStack()
    private let entityName = "CDAthlet"
    
    func all() -> [Athlet] {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        do {
            guard let results = try coreDataStack.managedObjectContext.fetch(fetchRequest) as? [CDAthlet] else {
                return []
            }
            
            return results.map { $0.dataEntity }
        } catch {
            print("There was a fetch error")
        }
        return []
    }
    
    
    func by(id: String) -> Athlet? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            guard let results = try coreDataStack.managedObjectContext.fetch(fetchRequest) as? [CDAthlet] else {
                return nil
            }
            
            return results.first?.dataEntity
        } catch {
            print("There was a fetch error")
        }
        return nil
    }
    
    
    func insert(item: Athlet) {
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: coreDataStack.managedObjectContext) else {
            fatalError("Coudn't find managedObjectContext")
        }
        
        let _ = CDAthlet(athlet: item, entity: entity, insertInto: coreDataStack.managedObjectContext)
        coreDataStack.saveContext()
    }
    
    
    func clean() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try coreDataStack.persistentStoreCoordinator.execute(deleteRequest, with: coreDataStack.managedObjectContext)
        } catch let error as NSError {
            // TODO: handle the error
            print(error)
        }
    }
    
    func update(item: Athlet) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "id == %@", item.id)
        do {
            
            guard
                let results = try coreDataStack.managedObjectContext.fetch(fetchRequest) as? [CDAthlet],
                let updatedItem = results.first else {
                    return
            }
            
            updatedItem.name = item.name
            updatedItem.id = item.id
            coreDataStack.saveContext()
            
        } catch {
            print("There was a fetch error")
        }
    }
    
    
    func delete(item: Athlet) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDAthlet")
        fetchRequest.predicate = NSPredicate(format: "id == %@", item.id)
        do {
            guard let results = try coreDataStack.managedObjectContext.fetch(fetchRequest) as? [CDAthlet] else {
                return
            }
            
            for object in results {
                coreDataStack.managedObjectContext.delete(object)
            }
        } catch {
            print("There was a fetch error")
        }
    }
}
