//
//  ItemDetailViewController.swift
//  ToDoList
//
//  Created by macbook air on 02.03.17.
//  Copyright © 2017 macbook air. All rights reserved.
//

import Foundation
import UIKit

protocol AddItemViewContollerDelegate: class {
  func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController)
  
  func itemDetailViewController(_ controller: ItemDetailViewController,
                             didFinishAdding item: ChecklistItem)
  
  func itemDetailViewController(_ controller: ItemDetailViewController,
                             didFinishEditing item: ChecklistItem)
}

class ItemDetailViewController: UITableViewController, UITextFieldDelegate {
  
  // This variable refers to the other view controller
  

  @IBOutlet weak var doneBarButton: UIBarButtonItem!
  @IBOutlet weak var textField: UITextField!
  
  weak var delegate: AddItemViewContollerDelegate?
  
  var itemToEdit: ChecklistItem? //itemToEdit will be nil.(optional)

//-----------------------------------------------------------------------------------------------
//                      *** View did load ***
//-----------------------------------------------------------------------------------------------
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let item = itemToEdit {
      title = "Edit Item"
      textField.text = item.text
      doneBarButton.isEnabled = true
    }
  }

//-----------------------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------------------
//                      *** Enable or disable "Done" bar button ***
//-----------------------------------------------------------------------------------------------
  
  func textField(_ textField: UITextField,
                 shouldChangeCharactersIn range: NSRange,
                 replacementString string: String) -> Bool {
    
    let oldText = textField.text! as NSString
    let newText = oldText.replacingCharacters(in: range, with: string) as NSString
    doneBarButton.isEnabled = (newText.length > 0)
    return true
  }

//-----------------------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------------------
//                      *** Done's action method ***
//-----------------------------------------------------------------------------------------------
  
  @IBAction func done() {
    
    if let item = itemToEdit {
      item.text = textField.text!
      delegate?.itemDetailViewController(self, didFinishEditing: item)
    
    } else {
  
    //this tells the app to close Add Item screen with an animation
    //Create the new checklist item object
    let item = ChecklistItem()
    item.text = textField.text!
    //directly call a method from ChecklistViewController
    item.checked = false
    
    delegate?.itemDetailViewController(self, didFinishAdding: item)
    
    }
  }
  
//-----------------------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------------------
//                      *** Cancel's action method ***
//-----------------------------------------------------------------------------------------------
  
  @IBAction func cancel() {
    // ? tells Swift not to send message if delegate is nil.
    delegate?.itemDetailViewControllerDidCancel(self)
    
  }
  
//-----------------------------------------------------------------------------------------------


//-----------------------------------------------------------------------------------------------
//                      *** Disable selections for the row *** ( table view delegate method )
//-----------------------------------------------------------------------------------------------
  
  override func tableView(_ tableView: UITableView,
                          willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    //the ? (question mark) tells Swift that you can also return nil from this method.
    print ("willSelectRowAt")
    return nil
  }

//-----------------------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------------------
//                      *** Keyboard automatically appeared ***
//-----------------------------------------------------------------------------------------------

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    textField.becomeFirstResponder()
  }
//-----------------------------------------------------------------------------------------------
 
}

























