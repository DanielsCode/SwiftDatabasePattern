//
//  AthletsRealmDataSource.swift
//  DatabasePattern
//
//  Created by Daniel Siegel on 28.12.16.
//  Copyright © 2016 Daniel Siegel. All rights reserved.
//

import Foundation
import RealmSwift


class AthletsRealmDataSource: DataSource {
    
    private let realm = try! Realm()
    
     var notificationToken: NotificationToken? = nil
    
    
    func all() -> [Athlet] {
        return realm.objects(RealmAthlet.self).map { $0.dataEntity }
    }
    
    func by(id: String) -> Athlet? {
        let predicate = NSPredicate(format: "id = %@", id)
        let realmAthlet = realm.objects(RealmAthlet.self).filter(predicate).first
        
        return realmAthlet?.dataEntity
    }
    
    
    func insert(item: Athlet) {
        try! realm.write {
            realm.add(RealmAthlet(athlet: item))
        }
    }
    
    func clean() {
        try! realm.write {
            realm.delete(realm.objects(RealmAthlet.self))
        }
    }
    
    func update(item: Athlet) {
        
        let predicate = NSPredicate(format: "id = %@", item.id)
        if let realmAthlet = realm.objects(RealmAthlet.self).filter(predicate).first {
            try! realm.write {
                realmAthlet.id = item.id
                realmAthlet.name = item.name
                
                realm.add(realmAthlet)
            }
        }
    }
    
    
    func delete(item: Athlet) {
        
        let predicate = NSPredicate(format: "id = %@", item.id)
        if let realmAthlet = realm.objects(RealmAthlet.self).filter(predicate).first {
            try! realm.write {
                realm.delete(realmAthlet)
            }
        }
    }
}
