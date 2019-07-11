//
//  CommanderTests.swift
//  StartupCommanderTests
//
//  Created by Paul Wood on 6/26/19.
//  Copyright © 2019 Paul Wood. All rights reserved.
//

import XCTest
@testable import StartupCommander

class CommanderTests: XCTestCase {
  
  
  
  func testTestCommands() {
    XCTAssertEqual(Commander.testCommands.count, 11)
  }
  
  
  func testCommands() {
    XCTAssertNotNil(CoreDataService(data: DataAssets.Commands.value))
  }
}
