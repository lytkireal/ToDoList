//
//  ViewController.swift
//  ToDoList
//
//  Created by macbook air on 13.02.17.
//  Copyright © 2017 macbook air. All rights reserved.
//

import UIKit

class ChecklistViewContoller: UITableViewController {
  //first piece of row's data source
  
  // data type of items variable is ChecklistItem
  var items: [ChecklistItem]
  
  
  
  required init? (coder aDecoder: NSCoder) {
    items = [ChecklistItem]()//"()" tell Swift to make the new array object
    
    let row0item = ChecklistItem()
    row0item.text = "Стакан воды"
    row0item.checked = false
    items.append(row0item)
    
    let row1item = ChecklistItem()
    row1item.text = "Утренний туалет"
    row1item.checked = false
    items.append(row1item)
    
    let row2item = ChecklistItem()
    row2item.text = "Коктейль"
    row2item.checked = false
    items.append(row2item)
    
    let row3item = ChecklistItem()
    row3item.text = "Зарядка"
    row3item.checked = false
    items.append(row3item)
    
    let row4item = ChecklistItem()
    row4item.text = "Душ"
    row4item.checked = false
    items.append(row4item)
    
    super.init(coder: aDecoder)
  }
  

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  //rows count in section (table view data source method)
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
    -> Int {
      return 100
  }
  
  
  //table view data source method
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
    
    let label = cell.viewWithTag(1000) as! UILabel
    
    if indexPath.row % 5 == 0 {
      label.text = row0item.text
    } else if indexPath.row % 5 == 1 {
      label.text = row1item.text
    } else if indexPath.row % 5 == 2 {
      label.text = row2item.text
    } else if indexPath.row % 5 == 3 {
      label.text = row3item.text
    } else if indexPath.row % 5 == 4 {
      label.text = row4item.text
    }
    
    configureCheckmark(for: cell, at: indexPath)
    return cell
  }
  
  //method of seleceted rows (table view delegate method)
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    //set $ unset checkmarks of rows
    if let cell = tableView.cellForRow(at: indexPath) {
      
      if indexPath.row == 0 {
        row0item.checked = !row0item.checked
      } else if indexPath.row == 1 {
        row1item.checked = !row1item.checked
      } else if indexPath.row == 2 {
        row2item.checked = !row2item.checked
      } else if indexPath.row == 3 {
        row3item.checked = !row3item.checked
      } else if indexPath.row == 4 {
        row4item.checked = !row4item.checked
      }
      configureCheckmark(for: cell, at: indexPath)
    }
    
    //deselect row if the user tapped
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  //configure all rows to unchecked state at start of app
  func configureCheckmark(for cell: UITableViewCell, at indexPath: IndexPath) {
    
    var isChecked = false
    
    if indexPath.row == 0 {
      isChecked = row0item.checked
    } else if indexPath.row == 1 {
      isChecked = row1item.checked
    } else if indexPath.row == 2 {
      isChecked = row2item.checked
    } else if indexPath.row == 3 {
      isChecked = row3item.checked
    } else if indexPath.row == 4 {
      isChecked = row4item.checked
    }
    if isChecked {
      cell.accessoryType = .checkmark
    } else {
      cell.accessoryType = .none
    }
  }
  
  
}



















