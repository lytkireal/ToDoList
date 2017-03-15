//
//  DataModel.swift
//  ToDoList
//
//  Created by macbook air on 15/03/2017.
//  Copyright © 2017 macbook air. All rights reserved.
//

import Foundation

class DataModel {
  var lists = [Checklist]()
  
  init() {
    loadChecklists()
  }
  
//-----------------------------------------------------------------------------------------------
//                      *** Saving and loading data of app ***
//-----------------------------------------------------------------------------------------------
  
  // 1) Documents directory
  func documentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory,
                                         in: .userDomainMask)
    return paths[0]
  }
  
  // 2) Data File Path (create *.plist file)
  func dataFilePath() -> URL {
    return documentsDirectory().appendingPathComponent("Checklists.plist")
  }
  
  // 3) Save checklists method
  func saveChecklists() {
    let data = NSMutableData() // data variable with type: NSMutableData
    let archiver = NSKeyedArchiver(forWritingWith: data) // create archiver to encode our data to binary code
    
    archiver.encode(lists, forKey: "Checklists")
    
    archiver.finishEncoding()
    data.write(to: dataFilePath(), atomically: true)
  }
  
  // 4) Load checklists method
  func loadChecklists() {
    let path = dataFilePath() // access to loaded "Checklists.plist"
    if let data = try? Data(contentsOf: path) {
      let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
      
      lists = unarchiver.decodeObject(forKey: "Checklists") as! [Checklist]
      unarchiver.finishDecoding()
    }
  }
//-----------------------------------------------------------------------------------------------
}
