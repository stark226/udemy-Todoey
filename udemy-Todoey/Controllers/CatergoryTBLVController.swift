//
//  CatergoryTBLVController.swift
//  udemy-Todoey
//
//  Created by stefano cardia on 04/10/18.
//  Copyright © 2018 Stefano Cardia. All rights reserved.
//

import UIKit
import CoreData

class CatergoryTBLVController: UITableViewController {
    
    
    let kCellId = "CategoryCell"
    let kToDoVCID = "ToDoListViewController"
    
    var categories = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategory()

    }

    
    
   
    func saveItems() {
        
        do {
            try context.save()
        } catch {
            print("wraning: \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    
    
    func loadCategory(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        //qui sopra "= Category.fetchRequest()" è un valore di default
        
        do {
            self.categories = try context.fetch(request)
            //            let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
            //            request.sortDescriptors = [sortDescriptor]
        } catch {
            print("WARNING: \(error)")
        }
        
        tableView.reloadData()
        
    }

    
    
   
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var globalTxField = UITextField()
        
        let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            
            let newCategory = Category(context: self.context)
            guard globalTxField.text != nil else {return}
            newCategory.name = globalTxField.text!
            
            self.categories.append(newCategory)
            
            self.saveItems()
            
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



extension CatergoryTBLVController {
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: self.kCellId, for: indexPath)
        
        cell.textLabel?.text = self.categories[indexPath.row].name
        
        return cell
    }
    
    
    
    func pushShowNextVC(categoryToPass: Category) {
        
        //ricorda: questa funziona ma SOLO se applico "embed in a navigation controller" al controller di inizo
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        if let newViewController = storyBoard.instantiateViewController(withIdentifier: kToDoVCID) as? ToDoListViewController {
            newViewController.selectedCategory = categoryToPass
            
            if let navigator = navigationController {
                navigator.pushViewController(newViewController, animated: true)
            }
        }
        
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        pushShowNextVC(categoryToPass: self.categories[indexPath.row])
        
    }
    
    
}
