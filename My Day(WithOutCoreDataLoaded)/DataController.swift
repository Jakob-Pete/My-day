//
//  DataController.swift
//  My Day(WithOutCoreDataLoaded)
//
//  Created by mac on 3/27/23.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Reminder")
    
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Failed to load core data: \(error.localizedDescription) ")
            }
            
        }
    }
}
