//
//  RealmAthlet.swift
//  DatabasePattern
//
//  Created by Daniel Siegel on 28.12.16.
//  Copyright © 2016 Daniel Siegel. All rights reserved.
//

import Foundation
import RealmSwift

class RealmAthlet: Object {
    dynamic var name: String = ""
    dynamic var id: String = ""
    
    convenience init(athlet: Athlet) {
        self.init()
        name = athlet.name
        id = athlet.id
    }
    
    var dataEntity: Athlet {
        return Athlet(withId: self.id, name: self.name)
    }
}
