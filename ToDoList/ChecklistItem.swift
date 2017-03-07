//
//  ChecklistItem.swift
//  ToDoList
//
//  Created by macbook air on 22.02.17.
//  Copyright © 2017 macbook air. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject {
  var text = ""
  var checked = false
  
  func toggleChecked() {
    checked = !checked
  }
}
