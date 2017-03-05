//
//  AddItemViewController.swift
//  ToDoList
//
//  Created by macbook air on 02.03.17.
//  Copyright © 2017 macbook air. All rights reserved.
//

import Foundation
import UIKit

protocol AddItemViewContollerDelegate: class {
  func addItemViewControllerDidCancel(_ controller: AddItemViewController)
  func addItemViewController(_ controller: AddItemViewController,
                             didFinishAdding item: ChecklistItem)
}

class AddItemViewController: UITableViewController, UITextFieldDelegate {
  
  // This variable refers to the other view controller
  //var checklistViewController: ChecklistViewContoller
  
//-----------------------------------------------------------------------------------------------
//                      *** Done's action method ***
//-----------------------------------------------------------------------------------------------
  @IBAction func done() {
    //this tells the app to close Add Item screen with an animation
    //Create the new checklist item object
    let item = ChecklistItem()
    item.text = textField.text!
    //directly call a method from ChecklistViewController
    item.checked = false
    
    delegate?.addItemViewController(self, didFinishAdding: item)
  }

//-----------------------------------------------------------------------------------------------

  @IBOutlet weak var doneBarButton: UIBarButtonItem!
  @IBOutlet weak var textField: UITextField!
  
  weak var delegate: AddItemViewContollerDelegate?

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
//                      *** Cancel's action method ***
//-----------------------------------------------------------------------------------------------
  
  @IBAction func cancel() {
    // ? tells Swift not to send message if delegate is nil.
    delegate?.addItemViewControllerDidCancel(self)
    
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

























