//
//  ColorAssetTests.swift
//  StartupCommanderTests
//
//  Created by Paul Wood on 7/12/19.
//  Copyright © 2019 Paul Wood. All rights reserved.
//

import XCTest
import SwiftUI
@testable import StartupCommander

class ColorAssetTests: XCTestCase {
  
  let traits = [
    UITraitCollection(userInterfaceStyle: .dark),
    UITraitCollection(userInterfaceStyle: .light),
    UITraitCollection(userInterfaceStyle: .unspecified),
  ]
  
  
  func testColorsReturn() {
    for c in ColorAsset.allCases {
      for t in traits {
        let _ = Color(c)
        let uiColor = UIColor(c)
        let _ = uiColor?.resolvedColor(with: t)
      }
    }
  }
}
