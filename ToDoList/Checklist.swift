//
//  Chec.swift
//  ToDoList
//
//  Created by macbook air on 09/03/2017.
//  Copyright © 2017 macbook air. All rights reserved.
//

import UIKit

class Checklist: NSObject, NSCoding {
  
  var name = ""
  var items = [ChecklistItem]()
  
  init(name: String) {
    self.name = name
    super.init()
  }
//-----------------------------------------------------------------------------------------------
//                      *** 2 required methods for NSCoding protocol ***
//-----------------------------------------------------------------------------------------------
  required init?(coder aDecoder: NSCoder) {
    name = aDecoder.decodeObject(forKey: "Name") as! String
    items = aDecoder.decodeObject(forKey: "Items") as! [ChecklistItem]
    super.init()
  }

  func encode(with aCoder: NSCoder) {
    aCoder.encode(name, forKey: "Name")
    aCoder.encode(items, forKey: "Items")
  }

//-----------------------------------------------------------------------------------------------

  
}
