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
        XCTAssertEqual(c.dynamicCommands.count, 13)
    }


}
