//
//  CDAthlet+CoreDataClass.swift
//  DatabasePattern
//
//  Created by Daniel Siegel on 28.12.16.
//  Copyright © 2016 Daniel Siegel. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData

// @objc(CDAthlet)
public class CDAthlet: NSManagedObject {

    
    var dataEntity: Athlet {
        return Athlet(withId: self.id, name: self.name!)
    }
    
    convenience init(athlet: Athlet, entity: NSEntityDescription, insertInto context: NSManagedObjectContext!) {
        self.init(entity: entity, insertInto: context)
        self.name = athlet.name
        self.id = athlet.id
    }
}
