//
//  ViewController.swift
//  ToDoList
//
//  Created by macbook air on 13.02.17.
//  Copyright © 2017 macbook air. All rights reserved.
//

import UIKit

class ChecklistViewContoller: UITableViewController,
                                  AddItemViewContollerDelegate {
  //first piece of row's data source
  
  // data type of items variable is ChecklistItem
  /*
   This declares that items will hold an array of ChecklistItem objects
   but it does not actually create that array.
   At this point, items does not have a value yet.
   */
  
  var items: [ChecklistItem]
  
  
  //data model of app
  required init? (coder aDecoder: NSCoder) { // to save the checklist items we will use the NSCoder system
    
    /* 
     1) When we add a view controller to a storyboard,
     Xcode uses the NSCoder system to write this object
     to a file (encoding).
     2) Then when our app starts up, it uses NSCoder again
     to read the objects from the storyboard file (decoding).
    */
    
    /*
     This instantiates the array. Now items contains a valid array object,
     but the array has no ChecklistItem objects inside it yet.
     */
    items = [ChecklistItem]()//"()" tell Swift to make the new array object

    //This instantiates the ChecklistItem object. Notice the ().
    let row0item = ChecklistItem()
      
    //Gives values to the data items inside the new ChecklistItem object.
    row0item.text = "Стакан воды"
    row0item.checked = false
      
    //This adds the ChecklistItem object into the items array.
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
    row4item.text = "Ванна"
    row4item.checked = false
    items.append(row4item)
    
    super.init(coder: aDecoder)
    
    print ("Documents folder is \(documentsDirectory())")
    print ("Data file path is \(dataFilePath())")
  
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

//-----------------------------------------------------------------------------------------------
//                      *** Rows count in section (table view data source method) ***
//-----------------------------------------------------------------------------------------------
  
  override func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int)
    -> Int {
      return items.count
  }
  
//-----------------------------------------------------------------------------------------------
//                      *** Create cells for each row in the table data source ***
//                                   (table view data source method)
//-----------------------------------------------------------------------------------------------
  
  override func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
    
    let item = items[indexPath.row]
    
    configureText(for: cell, with: item)
    configureCheckmark(for: cell, with: item)
    
    return cell // UITableViewCell object
  }

//-----------------------------------------------------------------------------------------------

  
//-----------------------------------------------------------------------------------------------
//                      *** Method of selected rows ***
//                        (table view delegate method)
//-----------------------------------------------------------------------------------------------
  
  override func tableView(_ tableView: UITableView,
                          didSelectRowAt indexPath: IndexPath) {
    
    //set $ unset checkmarks of rows
    if let cell = tableView.cellForRow(at: indexPath) {
      let item = items[indexPath.row]
      item.toggleChecked()
      configureCheckmark(for: cell, with: item)
    }
    //deselect row if the user tapped
    tableView.deselectRow(at: indexPath, animated: true)
    
    saveChecklistItems()
  }
  
//-----------------------------------------------------------------------------------------------
//                      *** Deleting rows (swipe-to-delete function) ***
//-----------------------------------------------------------------------------------------------
  
  override func tableView(_ tableView: UITableView,
                          commit editingStyle: UITableViewCellEditingStyle,
                          forRowAt indexPath: IndexPath) {
    //1
    items.remove(at: indexPath.row)
    //2
    let indexPaths = [indexPath]
    tableView.deleteRows(at: indexPaths, with: .automatic)
    saveChecklistItems()
  }
  
//-----------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------
//                      *** Prepare-for-segue ***
//-----------------------------------------------------------------------------------------------
  
  override func prepare(for segue: UIStoryboardSegue,
                        sender: Any?) {
    // 1
    if segue.identifier == "AddItem" {
      // 2
      let navigationController = segue.destination as! UINavigationController
      //3
      let controller = navigationController.topViewController as! ItemDetailViewController
      //4
      controller.delegate = self
      
    } else if segue.identifier == "EditItem" {
      
      let navigationController = segue.destination as! UINavigationController
      
      let controller = navigationController.topViewController as! ItemDetailViewController
      
      controller.delegate = self
            
      if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
        controller.itemToEdit = items[indexPath.row]
      }
    }
  }
  
//-----------------------------------------------------------------------------------------------
//                      *** Configuring checkmarks for rows in the table view ***
//-----------------------------------------------------------------------------------------------
  
  //configure all rows to unchecked state at start of app
  func configureCheckmark(for cell: UITableViewCell,
                          with item: ChecklistItem) {
    let label = cell.viewWithTag(1001) as! UILabel
    
    if item.checked {
      label.text = "√"
    } else {
      label.text = ""
    }
  }
//-----------------------------------------------------------------------------------------------

  func configureText (for cell: UITableViewCell,
                      with item: ChecklistItem) {
    
    let label = cell.viewWithTag(1000) as! UILabel
    label.text = item.text
  }
  
//-----------------------------------------------------------------------------------------------
//                      *** Implement methods from ItemDetailViewControllerDelegate ***
//-----------------------------------------------------------------------------------------------
  // 1
  func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController) {
    
    dismiss(animated: true, completion: nil)
  
  }
  // 2
  // add new ChecklistItem
  func itemDetailViewController(_ controller: ItemDetailViewController,
                             didFinishAdding item: ChecklistItem) {
    let newRowIndex = items.count
    items.append(item)
    
    let indexPath = IndexPath(row: newRowIndex, section: 0)
    let indexPaths = [indexPath]
    tableView.insertRows(at: indexPaths, with: .automatic)
    
    dismiss(animated: true, completion: nil)
    saveChecklistItems()
    
  }
  // 3
  // edit existing to-do items
  func itemDetailViewController(_ controller: ItemDetailViewController,
                               didFinishEditing item: ChecklistItem) {
      
      if let index = items.index(of: item) {
        
        let indexPath = IndexPath(row: index, section: 0)
        
        if let cell = tableView.cellForRow(at: indexPath) {
          
          configureText(for: cell, with: item)
        }
      }
    dismiss(animated: true, completion: nil)
    saveChecklistItems()
  }
//-----------------------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------------------
//                      *** The documents directory ***
//-----------------------------------------------------------------------------------------------
  
  func documentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    
    return paths[0]
  }
  
  func dataFilePath() -> URL {
    return documentsDirectory().appendingPathComponent("Checklists.plist")
    // "Checklists.plist" lives inside the Documents directory.
  }
  
//-----------------------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------------------
//                      *** Saving the checklist items ***
//-----------------------------------------------------------------------------------------------
  
  func saveChecklistItems() {
    
    let data = NSMutableData()
    
    // 1. NSKeyedArchiver, which is a form of NSCoder that creates plist files,
    // encodes the array and all the ChecklistItems in it into some of binary data
    // format that can be written to a file.
    let archiver = NSKeyedArchiver(forWritingWith: data)
    
    archiver.encode(items, forKey: "ChecklistItems")
    archiver.finishEncoding()
    
    
    // 2. That data is placed in an NSMutableData object(data),
    // which will write itself to the file specified by dataFilePath() method.
    data.write(to: dataFilePath(), atomically: true)
  }

//-----------------------------------------------------------------------------------------------




}



















