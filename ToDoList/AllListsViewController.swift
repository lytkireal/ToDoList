//
//  AllListsViewController.swift
//  ToDoList
//
//  Created by macbook air on 09/03/2017.
//  Copyright © 2017 macbook air. All rights reserved.
//

import UIKit

class AllListsViewController: UITableViewController, ListDetailViewControllerDelegate {

  var lists: [Checklist]
  
  required init? (coder aDecoder: NSCoder) {
    // 1
    lists = [Checklist]()
    
    // 2
    super.init(coder: aDecoder)

    // 3
    var list = Checklist(name: "Дни рождения" )
    lists.append(list)
    
    // 4
    list = Checklist(name: "Продукты" )
    lists.append(list)
    
    list = Checklist(name: "Крутые приложения")
    lists.append(list)
    
    list = Checklist(name: "Список дел")
    lists.append(list)
    
    
  }
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
  }

    // MARK: - Table view data source

//-----------------------------------------------------------------------------------------------
//                      *** To perform a segue when you tap a row ***
//-----------------------------------------------------------------------------------------------
  
  override func tableView(_ tableView: UITableView,
                          didSelectRowAt indexPath: IndexPath) {
    
    let checklist = lists[indexPath.row]
    performSegue(withIdentifier: "ShowChecklist", sender: checklist)
  }
  
//-----------------------------------------------------------------------------------------------

  override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return lists.count
  }

  
  override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
    let cell = makeCell(for: tableView)
    
    let checklist = lists[indexPath.row]
    cell.textLabel!.text = checklist.name
    cell.accessoryType = .detailDisclosureButton
    
    return cell
  }
  
//-----------------------------------------------------------------------------------------------
//                      *** Make a cell manually ***
//-----------------------------------------------------------------------------------------------
  
  func makeCell(for tableView: UITableView) -> UITableViewCell {
    let cellIdentifier = "Cell"
    if let cell =
      tableView.dequeueReusableCell(withIdentifier: cellIdentifier) {
      return cell
    } else {
      return UITableViewCell(style: .default,
                             reuseIdentifier: cellIdentifier)
    }
  }
  
//-----------------------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------------------
//                      *** Prepare-for-segue ***
//-----------------------------------------------------------------------------------------------

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if segue.identifier == "ShowChecklist" {
      let controller = segue.destination as! ChecklistViewContoller
      controller.checklist = sender as! Checklist
    } else if segue.identifier == "AddChecklist" {
      let navigationController = segue.destination as! UINavigationController
      
      let controller = navigationController.topViewController as! ListDetailViewController
      
      controller.delegate = self
      controller.checklistToEdit = nil
    }
  }

//-----------------------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------------------
//                      *** Implement methods for being ListDetailViewControllerDelegate ***
//-----------------------------------------------------------------------------------------------
  // cancel button tapped
  func listDetailViewControllerDidCancel(_ controller: ListDetailViewController) {
   
    dismiss(animated: true, completion: nil)
    
  }
  // done button tapped (adding)
  func listDetailViewController(_ controller: ListDetailViewController,
                                didFinishAdding checklist: Checklist) {
    let newRowIndex = lists.count
    lists.append(checklist)
    
    let indexPath = IndexPath(row: newRowIndex, section: 0)
    let indexPaths = [indexPath]
    tableView.insertRows(at: indexPaths, with: .automatic)
    
    dismiss(animated: true, completion: nil)
  }

  // done button tapped (editing)
  func listDetailViewController(_ controller: ListDetailViewController,
                                didFinishEditing checklist: Checklist) {
    if let index = lists.index(of: checklist) {
      
      let indexPath = IndexPath(row: index, section: 0)
      
      if let cell = tableView.cellForRow(at: indexPath) {
        
        cell.textLabel!.text = checklist.name
      
      }
    }
    dismiss(animated: true, completion: nil)
  }
  
//-----------------------------------------------------------------------------------------------


//-----------------------------------------------------------------------------------------------
//                      *** Deleting checklists ***
//-----------------------------------------------------------------------------------------------
  
  override func tableView(_ tableView: UITableView,
                          commit editingStyle: UITableViewCellEditingStyle,
                          forRowAt indexPath: IndexPath) {
    
    lists.remove(at: indexPath.row)
    
    let indexPaths = [indexPath]
    tableView.deleteRows(at: indexPaths, with: .automatic)
  }

  
//-----------------------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------------------
//                      *** Row editing table view delegate method (from storyboard)***
//-----------------------------------------------------------------------------------------------
  
  override func tableView(_ tableView: UITableView,
                          accessoryButtonTappedForRowWith indexPath: IndexPath) {
    
    let navigationController = storyboard!.instantiateViewController(
                                withIdentifier: "ListDetailNavigationController")
                                    as! UINavigationController
    
    let controller = navigationController.topViewController
                                    as! ListDetailViewController
    controller.delegate = self
    
    let checklist = lists[indexPath.row]
    controller.checklistToEdit = checklist
    
    present(navigationController, animated: true, completion: nil)
  }
  
//-----------------------------------------------------------------------------------------------
  
}





















