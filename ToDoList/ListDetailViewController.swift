//
//  ListDetailViewController.swift
//  ToDoList
//
//  Created by macbook air on 10/03/2017.
//  Copyright © 2017 macbook air. All rights reserved.
//

import UIKit

protocol ListDetailViewControllerDelegate: class {
  
  func listDetailViewControllerDidCancel(_ controller: ListDetailViewController)
  
  func listDetailViewController(_ controller: ListDetailViewController,
                                didFinishAdding checklist: Checklist )
  
  func listDetailViewController(_ controller: ListDetailViewController,
                                didFinishEditing checklist: Checklist)
}

class ListDetailViewController: UITableViewController, UITextFieldDelegate {
  
  @IBOutlet weak var textField: UITextField!
  @IBOutlet weak var doneBarButton: UIBarButtonItem!
  
  weak var delegate: ListDetailViewControllerDelegate?
  
  var checklistToEdit: Checklist?
  
//-----------------------------------------------------------------------------------------------
//                      *** View did load ***
//-----------------------------------------------------------------------------------------------
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let checklist = checklistToEdit {
      title = "Edit Checklist"
      textField.text = checklist.name
      doneBarButton.isEnabled = true
    }
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

//-----------------------------------------------------------------------------------------------
//                      *** User cannot select the table cell ***
//-----------------------------------------------------------------------------------------------
  
  override func tableView(_ tableView: UITableView,
                          willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    
    return nil
    
  }

//-----------------------------------------------------------------------------------------------
  
//-----------------------------------------------------------------------------------------------
//                      *** Done's action method ***
//-----------------------------------------------------------------------------------------------

  @IBAction func done() {
  
  if let checklist = checklistToEdit{
    checklist.name = textField.text!
  delegate?.listDetailViewController(self, didFinishEditing: checklist)
  } else {
    let checklist = Checklist(name: textField.text!)
    delegate?.listDetailViewController(self , didFinishAdding: checklist)
  }
  }

//-----------------------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------------------
//                      *** Cancel's action method ***
//-----------------------------------------------------------------------------------------------
  
  @IBAction func cancel() {
    delegate?.listDetailViewControllerDidCancel(self)
  }

//-----------------------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------------------
//                      *** Delegate method that enables or disables the Done button ***
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

}























