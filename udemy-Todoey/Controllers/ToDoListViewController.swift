//
//  ViewController.swift
//  udemy-Todoey
//
//  Created by stefano cardia on 29/09/18.
//  Copyright © 2018 Stefano Cardia. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray = [Item]()
    
//    let defaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Ironman"
        itemArray.append(newItem)
        
        let newItem1 = Item()
        newItem1.title = "Warmachine"
        itemArray.append(newItem1)
        
        let newItem2 = Item()
        newItem2.title = "black Widow"
        itemArray.append(newItem2)
        
        
    }

    
    //MARK: - datasource methods
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        let itemToUse = itemArray[indexPath.row]
        
        cell.textLabel?.text = itemToUse.title
        
        //se è vero vale il primo valore, se è falso il secondo
        cell.accessoryType = itemToUse.done  ?  .checkmark : .none

        
        
        return cell
        
    }
    
    
    //MARK: - delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.itemArray[indexPath.row].done = !self.itemArray[indexPath.row].done
        
        
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        } else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        tableView.reloadData()
    }
    
    
    
    //MARK: add new items section
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
    
        var globalTxField = UITextField()
        
        let alert = UIAlertController(title: "Add new Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let newItem = Item()
            guard globalTxField.text != nil else {return}
            newItem.title = globalTxField.text!
            
            self.itemArray.append(newItem)
            
            self.tableView.reloadData()

        }
        
        alert.addTextField { (alertTXFLD) in
            alertTXFLD.placeholder = "Create new item"
            globalTxField = alertTXFLD
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    

}

