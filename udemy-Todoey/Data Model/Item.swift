//
//  Item.swift
//  udemy-Todoey
//
//  Created by stefano cardia on 07/10/18.
//  Copyright © 2018 Stefano Cardia. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated : Date?
    //relazioni del database
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    
}
