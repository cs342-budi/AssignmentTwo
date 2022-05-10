//
//  PersistenceController.swift
//  CardinalKit_Example
//
//  Created by Taylor  Lallas on 4/30/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import CoreData


struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    init(){
        container = NSPersistentContainer(name: "BudiModel" )
        container.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func save(completion: @escaping (Error?) -> () = { _ in}) {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
                completion(nil)
            } catch {
                completion(error)
            }
        }
    }
    
    func delete(_ object: NSManagedObject, completion: @escaping (Error?) -> () = { _ in}) {
        let context = container.viewContext
        context.delete(object)
        save(completion: completion)
    }
}
