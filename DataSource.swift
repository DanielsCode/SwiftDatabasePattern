//
//  DataSource.swift
//  DatabasePattern
//
//  Created by Daniel Siegel on 28.12.16.
//  Copyright © 2016 Daniel Siegel. All rights reserved.
//

import Foundation

// CRUD (Create Read Update Delete) interface

/* Not Used
enum DataSourceChangeState: Int {
    case initial
    case update
    case error
}
*/

protocol DataSource {
    associatedtype T
    
    func all() -> [T]
    func by(id: String) -> T?
    func insert(item: T)
    func update(item: T)
    func delete(item: T)
    func clean()
}

