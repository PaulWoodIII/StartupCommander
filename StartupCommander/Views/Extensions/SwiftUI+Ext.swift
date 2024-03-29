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

struct TopLeading: ViewModifier {
  
  func body(content: Content) -> some View {
    return content.frame(
      minWidth: 0, maxWidth: .infinity,
      minHeight: 0, maxHeight: .infinity,
      alignment: .topLeading
    )
  }
}


