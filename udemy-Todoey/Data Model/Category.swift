//
//  Category.swift
//  udemy-Todoey
//
//  Created by stefano cardia on 07/10/18.
//  Copyright © 2018 Stefano Cardia. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var name : String = ""
    
//    relazioni del database
    
    let items = List<Item>() //one to many relationship
    
}
