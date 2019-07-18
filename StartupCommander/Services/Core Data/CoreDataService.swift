//
//  CoreDataService.swift
//  StartupCommander
//
//  Created by Paul Wood on 7/9/19.
//  Copyright © 2019 Paul Wood. All rights reserved.
//

import Foundation
import CoreData
import Combine


class CoreDataService: NSObject {
  
  struct Error: Swift.Error, Equatable {
    
  }
  
  var initialCommands: [CommandKeys] = []
  
  // injectable Container Service for test to use in memeory stores
  var coreDataContainerService: CoreDataContainerServiceType = CoreDataContainerService()
  
  // Convienance getter
  var persistentContainer: NSPersistentContainer {
    coreDataContainerService.persistentContainer
  }
  
  lazy private var fetchedResultsController: NSFetchedResultsController<Command> = {
    
    let sort = NSSortDescriptor(key: "title", ascending: true)
    let req: NSFetchRequest<Command> = Command.fetchRequest()
    req.sortDescriptors = [sort]
    let moc = persistentContainer.viewContext
    let controller: NSFetchedResultsController<Command> =
      NSFetchedResultsController(fetchRequest: req,
                                 managedObjectContext: moc,
                                 sectionNameKeyPath: nil,
                                 cacheName: "Commands")
    controller.delegate = self
    return controller
  }()
  
  @Published var commands: [Command] = []
  private var _didChange = PassthroughSubject<Void, Never>()
  
  init?(data: Data) {
    let decoder = JSONDecoder()
    if let commands = try? decoder.decode([CommandKeys].self,
                                          from: data) {
      self.initialCommands = commands
    } else {
      return nil
    }
    
    
    // TODO:
    // On Application close or terminate we need to save
    // On sceneDidEnterBackground also save
    // self.saveContext()
  }
  
  func startup() -> AnyPublisher<[Command], Error> {
    
    return checkForCommands().flatMap{ commands -> AnyPublisher<[Command], Error> in
      self.commands = commands
      _ = self.fetchedResultsController
      if commands.count > 0 {
        self.commands = commands
        return Just<[Command]>(commands)
          .setFailureType(to: Error.self)
          .eraseToAnyPublisher()
      }
      return self.saveInitialToCoreData().eraseToAnyPublisher()
    }.eraseToAnyPublisher()
  }
  
  func checkForCommands() -> AnyPublisher<[Command], Error> {
    let context = self.persistentContainer.viewContext
    let fetchRequest: NSFetchRequest<Command> = Command.fetchRequest()
    // Set the batch size to a suitable number.
    fetchRequest.fetchBatchSize = 100
    return Future<[Command],Error>.init { promise in
      do {
        let fetched = try context.fetch(fetchRequest)
        promise(.success(fetched))
      } catch {
        promise(.failure(Error()))
      }
    }.eraseToAnyPublisher()
  }
  
  func saveInitialToCoreData() -> AnyPublisher<[Command], Error> {
    let commands = self.initialCommands.map { (key) -> Command in
      return Command.create(self.persistentContainer.viewContext, commandKey: key)
    }
    self.commands = commands
    return Just<[Command]>(commands)
      .setFailureType(to: Error.self)
      .eraseToAnyPublisher()
  }
  
  // MARK: - Delete
  func deleteAllCommands() -> AnyPublisher<Void, Error> {
    
    
    return Future<Void, Error>.init { promise in
      let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Command.self))
      let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
      deleteRequest.resultType = .resultTypeObjectIDs
      let context = self.persistentContainer.viewContext
      do {
        let result = try context.execute(deleteRequest) as? NSBatchDeleteResult
        let changes: [AnyHashable: Any] = [NSDeletedObjectsKey: result?.result as? [NSManagedObjectID] ?? []]
        NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: [context])
        self.commands = []
        promise(.success(()))
      } catch {
        promise(.failure(Error()))
      }
    }.eraseToAnyPublisher()
  }
  
  // MARK: - Core Data Saving support
  func saveContext () -> AnyPublisher<Void, Error> {
    return Future<Void, Error>.init { promise in
      let context = self.persistentContainer.viewContext
      if context.hasChanges {
        do {
          try context.save()
          promise(.success(()))
        } catch {
          promise(.failure(Error()))
        }
      }
      promise(.success(()))
    }.eraseToAnyPublisher()
  }
}

extension CoreDataService: NSFetchedResultsControllerDelegate {
  
  // MARK: - Updates to Commands
  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    if let newObjects = controller.fetchedObjects as? [Command] {
      commands = newObjects
    }
  }
}
