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
    
    func getAll() -> [Athlet] {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDAthlet")
        
        do {
            if let results = try coreDataStack.managedObjectContext.fetch(fetchRequest) as? [CDAthlet] {
                return results.map { $0.dataEntity }
            }
        } catch {
            print("There was a fetch error")
        }
        return []
    }
    
    
    func getById(id: String) -> Athlet? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDAthlet")
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            if let results = try coreDataStack.managedObjectContext.fetch(fetchRequest) as? [CDAthlet] {
                return results.first?.dataEntity
            }
        } catch {
            print("There was a fetch error")
        }
        return nil
    }
    
    
    func insert(item: Athlet) {
        guard let entity = NSEntityDescription.entity(forEntityName: "CDAthlet", in: coreDataStack.managedObjectContext) else {
            fatalError("Coudn't find managedObjectContext")
        }
        
        let _ = CDAthlet(athlet: item, entity: entity, insertInto: coreDataStack.managedObjectContext)
        coreDataStack.saveContext()
    }
    
    
    func clean() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDAthlet")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try coreDataStack.persistentStoreCoordinator.execute(deleteRequest, with: coreDataStack.managedObjectContext)
        } catch let error as NSError {
            // TODO: handle the error
            print(error)
        }
    }
    
    func update(item: Athlet) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDAthlet")
        fetchRequest.predicate = NSPredicate(format: "id == %@", item.id)
        do {
            if let results = try coreDataStack.managedObjectContext.fetch(fetchRequest) as? [CDAthlet] {
                if let updatedItem = results.first {
                    updatedItem.name = item.name
                    updatedItem.id = item.id
                    coreDataStack.saveContext()
                }
                
            }
        } catch {
            print("There was a fetch error")
        }
    }
    
    
    func delete(item: Athlet) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDAthlet")
        fetchRequest.predicate = NSPredicate(format: "id == %@", item.id)
        do {
            if let results = try coreDataStack.managedObjectContext.fetch(fetchRequest) as? [CDAthlet] {
                for object in results {
                    coreDataStack.managedObjectContext.delete(object)
                }
            }
        } catch {
            print("There was a fetch error")
        }
    }
}
