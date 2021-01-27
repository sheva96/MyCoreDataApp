//
//  StorageManager.swift
//  MyCoreDataApp
//
//  Created by Yevhen Shevchenko on 27.01.2021.
//

import Foundation
import CoreData

class StorageManager {
    static let shared = StorageManager()
    
    // MARK: - Core Data stack

    private let persistentContainer: NSPersistentContainer = {
       
        let container = NSPersistentContainer(name: "MyCoreDataApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Context
    
    private let context: NSManagedObjectContext
    
    private init() {
        context = persistentContainer.viewContext
    }
    
    // MARK: - Fetch
    
    func fetchData() -> [Task] {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        
        do {
            return try context.fetch(fetchRequest)
        } catch let error {
            print(error)
            return []
        }
    }
    
    // MARK: Save
    
    func save(_ name: String, completion: (Task) -> Void) {
        /*
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "Task", in: context) else { return }
        guard let task = NSManagedObject(entity: entityDescription, insertInto: context) as? Task else { return }
         */
        
        let task = Task(context: context)
        task.name = name
        
        completion(task)
        saveContext()
    }
    
    // MARK: Edit

    func edit(_ task: Task, newName: String) {
        task.name = newName
        saveContext()
    }
    
    // MARK: Delete

    func delete(_ task: Task) {
        context.delete(task)
        saveContext()
    }
    
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
