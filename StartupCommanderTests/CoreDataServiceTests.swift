//
//  CoreDataServiceTests.swift
//  StartupCommanderTests
//
//  Created by Paul Wood on 7/9/19.
//  Copyright © 2019 Paul Wood. All rights reserved.
//

import XCTest
import Combine
import Entwine
import EntwineTest
import CoreData
@testable import StartupCommander

class CoreDataServiceTests: XCTestCase {
  
  var sut: CoreDataService!
  
  func testIsEmptyOnInit() {
    let testScheduler = TestScheduler(initialClock: 0)
    
    sut = CoreDataService(data: DataAssets.Commands.value)!
    sut.coreDataContainerService = TestPersistentContainer()
    
    // schedules a subscription at 200, to be cancelled at 900
    let results = testScheduler.start { self.sut.checkForCommands().map{return $0.count > 0} }
    
    XCTAssertEqual(results.sequence, [
      (200, .subscription),
      (200, .input(false)),
      (200, .completion(.finished))
    ])
  }
  
  
  func testIsLoadsFromDiskWhenStartup() {
    
    let testScheduler = TestScheduler(initialClock: 0)
    
    sut = CoreDataService(data: DataAssets.Commands.value)!
    let testContainer = TestPersistentContainer()
    let moc = testContainer.persistentContainer.viewContext
    sut.coreDataContainerService = testContainer
    
    _ = Command.create(moc, commandKey: CommandKeyDebug.commands[0])
    try! sut.persistentContainer.viewContext.save()
    
    let results = testScheduler.start { self.sut.checkForCommands().map{return $0.count > 0} }
    
    XCTAssertEqual(results.sequence, [
      (200, .subscription),
      (200, .input(true)),
      (200, .completion(.finished))
    ])
  }
  
  func testInitialCommandsAdded() {
    let testScheduler = TestScheduler(initialClock: 0)
    
    sut = CoreDataService(data: DataAssets.Commands.value)!
    sut.coreDataContainerService = TestPersistentContainer()
    
    // schedules a subscription at 200, to be cancelled at 900
    let results = testScheduler.start {
      self.sut.startup().map{ commands -> [String] in
        return commands.compactMap {$0.title}
      }.eraseToAnyPublisher()
    }
    
    // Expected values are the initial command values
    let expected = sut.initialCommands.map{ key in
      return key.title
    }
    
    XCTAssertEqual(results.sequence, [
      (200, .subscription),
      (200, .input(expected)),
      (200, .completion(.finished)),
    ])
  }
  
  func testDeleteAllCommandsAdded() {
    let testScheduler = TestScheduler(initialClock: 0)
    
    sut = CoreDataService(data: DataAssets.Commands.value)!
    sut.coreDataContainerService = TestPersistentContainer()
    
    _ = Command.create(sut.persistentContainer.viewContext,
                       commandKey: CommandKeyDebug.commands[0])
    try! sut.persistentContainer.viewContext.save()
    
    /*TestableSubscriber<[Command], Never>*/
    let _: TestableSubscriber<Void, NSError> = testScheduler.start { () -> AnyPublisher<Void, NSError> in
      
      let startupToDelete: AnyPublisher<Void, NSError> =
        self.sut.startup().map { _ in
          XCTAssertEqual(self.sut.commands.count, 1)
          XCTAssertNotNil(self.sut.commands.first?.title ?? nil)
          XCTAssertEqual(self.sut.commands.first?.title ?? "NOT",
                         CommandKeyDebug.commands.first!.title)
        }.flatMap { _ in
          return self.sut.deleteAllCommands()
        }.eraseToAnyPublisher()
      
      return startupToDelete
    }
    
    XCTAssertEqual(sut.commands.count, 0)
  }
  
  
}
