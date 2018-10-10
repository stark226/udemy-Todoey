//
//  CatergoryTBLVController.swift
//  udemy-Todoey
//
//  Created by stefano cardia on 04/10/18.
//  Copyright © 2018 Stefano Cardia. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

class CatergoryTBLVController: UITableViewController {
    
    
    //realm
    let realm = try! Realm()
    
    
    
    
    
    let kCellId = "CategoryCell"
    let kToDoVCID = "ToDoListViewController"
    
//    var categories = [Category]()
    
    var categories : Results<Category>?

    
    //commentato per uso di realm
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategory()

    }

    
    
   //con coreDAta
//    func saveItems() {
//
//        do {
//            try context.save()
//        } catch {
//            print("wraning: \(error)")
//        }
//
//        self.tableView.reloadData()
//    }
    
    
    func save(category: Category) {
        
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("wraning: \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    
    //commentato per uso di realm
//    func loadCategory(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
//        //qui sopra "= Category.fetchRequest()" è un valore di default
//
//        do {
//            self.categories = try context.fetch(request)
//            //            let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
//            //            request.sortDescriptors = [sortDescriptor]
//        } catch {
//            print("WARNING: \(error)")
//        }
//
//        tableView.reloadData()
//
//    }
    
    func loadCategory() {
        
        categories = realm.objects(Category.self)
        tableView.reloadData()

    }
    
    
   
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var globalTxField = UITextField()
        
        let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            //coreData
//            let newCategory = Category(context: self.context)
            //realm
            let newCategory = Category()
            guard globalTxField.text != nil else {return}
            newCategory.name = globalTxField.text!
            
            //commentato visto che in realm si aggironano automaticamente
//            self.categories.append(newCategory)
            
            self.save(category: newCategory)
            
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
//        return categories.count
        
        //realm
        return categories?.count ?? 1 //coaleshing operator

    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: self.kCellId, for: indexPath)
        
//        cell.textLabel?.text = self.categories[indexPath.row].name

        //realm
        cell.textLabel?.text = self.categories?[indexPath.row].name ?? "No Categories added yet"

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
        
//        pushShowNextVC(categoryToPass: self.categories[indexPath.row])
        
        pushShowNextVC(categoryToPass: self.categories?[indexPath.row] ?? Category())

    }
    
    
}
