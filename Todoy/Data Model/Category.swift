//
//  Category.swift
//  Todoy
//
//  Created by Damian Piszcz on 03/12/2020.
//

import Foundation
import RealmSwift



class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
    
}
