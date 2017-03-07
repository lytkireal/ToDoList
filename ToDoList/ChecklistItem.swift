//
//  ChecklistItem.swift
//  ToDoList
//
//  Created by macbook air on 22.02.17.
//  Copyright © 2017 macbook air. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject, NSCoding {
  var text = ""
  var checked = false
  
  func encode(with aCoder: NSCoder) {
    aCoder.encode(text, forKey: "Text")
    aCoder.encode(checked, forKey: "Checked")
  }
  
  required init? (coder aDecoder: NSCoder) {
    super.init()
  }
  
  override init() {
    super.init()
  }
  
  func toggleChecked() {
    checked = !checked
  }
  
}
