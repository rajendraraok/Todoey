//
//  ViewController.swift
//  Todoey
//
//  Created by Rajendra Rao Keyyur on 31/10/19.
//  Copyright © 2019 Rajendra Rao Keyyur. All rights reserved.
//

import UIKit
import Foundation

class TodoListViewController: UITableViewController {
    
    
    
    var itemArray = Array<Item>()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory,in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(dataFilePath)
        
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Bags"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Milk"
        itemArray.append(newItem3)
        
        loadItems()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        cell.accessoryType =  item.done ? .checkmark : .none
        
        return cell
    }
    
    //MARK:- TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
        saveItems()
    }
    
    //MARK:- Add new items
    
    @IBAction func addButtonPressed(_ sender: Any) {
        
        var textField = UITextField()
        let alert =  UIAlertController(title: "Add new Todeoy item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Items", style: .default) { (action) in
            
            let newItem =  Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            self.saveItems()
            
            //    self.defaults.set(self.itemArray, forKey: "TodoListArray")
            self.tableView.reloadData()
            
        }
        alert.addTextField { (alerttextField) in
            alerttextField.placeholder = "Create New Item"
            textField = alerttextField
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func saveItems()
    {
        let encoder = PropertyListEncoder()
        do{
            let data =  try encoder.encode(self.itemArray)
            try data.write(to: self.dataFilePath!)
        } catch{
            print("Error \(error)")
        }
    }
    
    func loadItems()
    {
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
                itemArray = try decoder.decode([Item].self, from: data)
            }catch{
                print("Error \(error)")
            }
        }
    }
}

