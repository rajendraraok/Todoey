//
//  ViewController.swift
//  Todoey
//
//  Created by Rajendra Rao Keyyur on 31/10/19.
//  Copyright © 2019 Rajendra Rao Keyyur. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = ["Find Mike","Buy Eggs", "Destroy Demogorgon"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    //MARK:- TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark

        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
  //MARK:- Add new items
    
    @IBAction func addButtonPressed(_ sender: Any) {
        
        var textField = UITextField()
        let alert =  UIAlertController(title: "Add new Todeoy item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Items", style: .default) { (action) in
            self.itemArray.append(textField.text!)
            self.tableView.reloadData()
           
            }
        alert.addTextField { (alerttextField) in
        alerttextField.placeholder = "Create New Item"
        textField = alerttextField
       
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

