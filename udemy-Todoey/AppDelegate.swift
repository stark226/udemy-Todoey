//
//  AppDelegate.swift
//  udemy-Todoey
//
//  Created by stefano cardia on 29/09/18.
//  Copyright © 2018 Stefano Cardia. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        
       //dove si trova quello che salva realm?
        print(Realm.Configuration.defaultConfiguration.fileURL)
        
//        let data = Data()
//        data.name = "Stefano"
//        data.age = 12
        
        //questo serve solo epr vedere se sin dall'inizio ci sono errori in realm
        do {
            //non metto let o va o un nome perchè non lo uso, è solo un controllo
            _ = try Realm() //di fatto è come i "container" usato in coreData
//            try realm.write {
//                realm.add(data)
//            }
        } catch {
            print("WARNING: issue with realm \(error)")
        }
        
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        self.saveContext()
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
       
        let container = NSPersistentContainer(name: "DataModel") //coreData_my_bonelli
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }


}

