//
//  CDAthlet+CoreDataProperties.swift
//  DatabasePattern
//
//  Created by Daniel Siegel on 28.12.16.
//  Copyright © 2016 Daniel Siegel. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension CDAthlet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDAthlet> {
        return NSFetchRequest<CDAthlet>(entityName: "CDAthlet");
    }

    @NSManaged public var name: String?
    @NSManaged public var id: String

}
