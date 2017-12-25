//
//  Item.swift
//  todo
//
//  Created by Peter on 24.05.17.
//  Copyright (c) 2017 Peter. All rights reserved.
//

import Foundation

import UIKit

//this is simple, we define 2 string type values and then access it by reference from any part

class Item: NSObject, NSCoding {
    func encode(with aCoder: NSCoder) {
    
    }
    
    var name: String
    var date: String
    
    //for storing data, first is default app directory which is ok for now
    static let Dir = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = Dir.appendingPathComponent("items")
    
    required init (name: String, date: String) {
        self.name = name
        self.date = date
    }
    
    
    //access to Db
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(date, forKey: "date")
    }
    
    required init(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.date = aDecoder.decodeObject(forKey: "date") as! String
    }
}
