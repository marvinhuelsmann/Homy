//
//  Persistence.swift
//  HomeWorkPlanner
//
//  Created by Marvin Hülsmann on 17.02.21.
//

import CoreData

/// Read the Data from the CoreData
struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "Data")
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(String(describing: error))")
            }
        }
    }
}
