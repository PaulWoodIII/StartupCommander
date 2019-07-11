//
//  TestPersistentContainer.swift
//  StartupCommanderTests
//
//  Created by Paul Wood on 7/9/19.
//  Copyright © 2019 Paul Wood. All rights reserved.
//

import Foundation
import CoreData
@testable import StartupCommander

class TestPersistentContainer: CoreDataContainerServiceType {
  lazy var persistentContainer: NSPersistentContainer = {
    /*
     The persistent container for the Test. This implementation
     creates and returns an in memory container
     */
    
    let container = NSPersistentContainer(name: "StartupCommander")
    let description = container.persistentStoreDescriptions.first!
    description.url = URL(fileURLWithPath: "/dev/null")
    try! container.persistentStoreCoordinator
      .destroyPersistentStore(at: URL(fileURLWithPath: "/dev/null"),
                              ofType: NSSQLiteStoreType,
                              options: [:])
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    
    
    return container
  }()
}

