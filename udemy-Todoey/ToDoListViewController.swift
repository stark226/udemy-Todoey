//
//  ViewController.swift
//  udemy-Todoey
//
//  Created by stefano cardia on 29/09/18.
//  Copyright © 2018 Stefano Cardia. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    let itemArray = ["Ironman", "Warmachine", "Blackwidow"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    //MARK: - datasource methods
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        cell.textLabel?.text = self.itemArray[indexPath.row]
        
        return cell
        
    }
    
    
    //MARK: - delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    
    

}
