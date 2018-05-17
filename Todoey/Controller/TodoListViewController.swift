//
//  ViewController.swift
//  Todoey
//
//  Created by Mirshad Ozuturk on 5/2/18.
//  Copyright © 2018 Mirshad Ozuturk. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray: [Item] = []
    
    // Setup User defaults as "standard" so that we can persist user entered data in our Todo list
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        var newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        var newItem2 = Item()
        newItem2.title = "Save the world!"
        itemArray.append(newItem2)
        
        var newItem3 = Item()
        newItem3.title = "Hello Goga!"
        itemArray.append(newItem3)
        
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
            
            itemArray = items
        }
        
        
        
    }

    // MARK - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        // Ternary operator to check for accessoryType state
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }

    // MARK - TableView Delegate Methods

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(itemArray[indexPath.row])
        
        // Add tick for each item or remove it
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    // MARK - Add IBAction to add Todo items
    @IBAction func addNewItem(_ sender: Any) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            
            // What will happen when user clicks on Add item button
            print("Success")
            print("Added item: \(textField.text!)")
            // Adding newly created item into array
                
            var newItem = Item()
            newItem.title = textField.text!
                
            self.itemArray.append(newItem)
                
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
                
            self.tableView.reloadData()
            
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        
    }
    
    
    
}

