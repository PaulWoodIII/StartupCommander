//
//  ColorAssets.swift
//  StartupCommander
//
//  Created by Paul Wood on 7/11/19.
//  Copyright © 2019 Paul Wood. All rights reserved.
//

import Foundation
import SwiftUI

/// Colors available in the Asset Catalog, Creating a typesafe method of accessing
/// these colors. Change once, change everywhere. We only need to ensure that a
/// case matches the name of the color in the Catalog exactly here
enum ColorAsset: String, CaseIterable {
  
  case Green
  case Red
  case Orange
  case Background
  case Background2
  case Background3
  case Empty
  
  var color: Color {
    return Color(self.rawValue)
  }
}

/// Initalize a Color with a ColorAsset case
extension Color {
  init(_ ca:ColorAsset) {
    self = Color(ca.rawValue)
  }
}

extension UIColor {
  convenience init?(_ ca: ColorAsset) {
    self.init(named: ca.rawValue)
  }
}
