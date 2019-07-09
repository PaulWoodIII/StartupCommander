//
//  SwiftUI+Ext.swift
//  StartupCommander
//
//  Created by Paul Wood on 6/26/19.
//  Copyright © 2019 Paul Wood. All rights reserved.
//

import SwiftUI

extension View {
  /// Returns a type-erased version of the view.
  public var typeErased: AnyView { AnyView(self) }
}
