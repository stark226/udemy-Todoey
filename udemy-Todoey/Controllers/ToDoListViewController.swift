//
//  ViewController.swift
//  udemy-Todoey
//
//  Created by stefano cardia on 29/09/18.
//  Copyright © 2018 Stefano Cardia. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

class ToDoListViewController: UITableViewController {

//    var todoItems = [Item]()
    var todoItems : Results<Item>?

    let realm = try! Realm()
    
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    //appena viene riempita con i dati del precedente VC si cerca i risultati:
    var selectedCategory : Category? {
        didSet {
            //questa func sta usando il parametro di default
            loadItems()     //commented for uing realm

        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //dove vengono salvati i dati nell'app, per leggere il database potresti avere un'applciazione che lo facci
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        if let name = self.selectedCategory?.name {
            self.title = name
        }
        
        
    }
    
    
    
    //MARK: - datasource methods
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        if let itemToUse = todoItems?[indexPath.row] {
            cell.textLabel?.text = itemToUse.title
            
            //se è vero vale il primo valore, se è falso il secondo
            cell.accessoryType = itemToUse.done  ?  .checkmark : .none
        } else {
            cell.textLabel?.text = "No items added"
        }
        
        

        
        
        return cell
        
    }
    
    
    //MARK: - delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //commentato per realm
//        self.todoItems[indexPath.row].done = !self.todoItems[indexPath.row].done
        
//        self.context.delete(self.todoItems[indexPath.row])
//        self.todoItems.remove(at: indexPath.row)
//
        //commentato per realm
//        self.saveItems()
        
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        } else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
        
        //in realm
        if let item = todoItems?[indexPath.row] {
            do {
                try realm.write{
                    item.done = !item.done //questo è il modo per modificare qualcosa
//                    realm.delete(item) //questo è il modo per cancellare qualcosa
                }
            } catch {
                print("error saving done status: \(error)")
            }
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        tableView.reloadData()
    }
    
    
    
    //MARK: add new items section
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
    
        var globalTxField = UITextField()
        
        let alert = UIAlertController(title: "Add new Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            //commented for using realm
//            let newItem = Item(context: self.context)
//            guard globalTxField.text != nil else {return}
//            newItem.title = globalTxField.text!
//            newItem.done = false
//            newItem.parentCategory = self.selectedCategory // 1/2 qui impieghiamo la relazione con la Category
//
//            self.todoItems.append(newItem)
            
//            self.saveItems()

            
            if let currentCategory = self.selectedCategory {
                
                do {
                    try self.realm.write {
                        let newItem = Item()
                        guard globalTxField.text != nil else {return}
                        newItem.title = globalTxField.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    }
                } catch {
                    print("error saving item \(error)")
                }
            }

//            newItem.parentCategory = self.selectedCategory // 1/2 qui impieghiamo la relazione con la Category
//            self.todoItems.append(newItem)
            
            self.tableView.reloadData()

        }
        
        alert.addTextField { (alertTXFLD) in
            alertTXFLD.placeholder = "Create new item"
            globalTxField = alertTXFLD
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    
    
    //commentato per realm
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
    
    
    
    
    
    
    //commented for uing realm
//
//    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {
//        //qui sopra "= Item.fetchRequest()" è un valore di default
//
//        // 2/2 qui impostiamo un filtro che, vi sia o meno in precedenza, richiama i diati in base al nome della categoria:
//        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
//
//        if let additionalPredicate = predicate {
//            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
//        } else {
//            request.predicate = categoryPredicate
//        }
//
//
//        do {
//            self.todoItems = try context.fetch(request)
////            let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
////            request.sortDescriptors = [sortDescriptor]
//        } catch {
//            print("WARNING: \(error)")
//        }
//
//        tableView.reloadData()
//
//    }
    
    
    func loadItems() {

        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)

        tableView.reloadData()
    }
    
}


//commented for uing realm

//
//extension ToDoListViewController : UISearchBarDelegate {
//
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
//
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
////        request.predicate = predicate /7inutile qui, inserita come argomento in loadItems()
//
//        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
//        request.sortDescriptors = [sortDescriptor]
//
//        loadItems(with: request, predicate: predicate)
//
//    }
//
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//
//        if searchBar.text?.count == 0 {
//
//            loadItems()
//
//            DispatchQueue.main.async {
//                searchBar.resignFirstResponder()
//            }
//
//        }
//
//    }
//
//
//
//}

extension ToDoListViewController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "title", ascending: true)
//        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)

    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text?.count == 0 {
            
            loadItems()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
        }
    
    }
}
