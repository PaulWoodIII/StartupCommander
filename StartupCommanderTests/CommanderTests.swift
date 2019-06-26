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

    func testExample() {
        let c = Commander(data: DataAssets.Commands.value)
        XCTAssert(c.dynamicCommands != nil)
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }


}
