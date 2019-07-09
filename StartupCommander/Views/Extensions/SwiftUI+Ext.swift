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

extension View {
  func presentation<T: View>(_ isShown: Binding<Bool>, title: Text, modal: () -> T) -> some View {
    let view = NavigationView {
      modal()
        .navigationBarTitle(title)
        .navigationBarItems(trailing: Button(action: {
          isShown.value.toggle()
        }, label: { Text("Done") } ))
    }
    
    return presentation(isShown.value ?
      Modal(
        view,
        onDismiss: {
          isShown.value.toggle()
      }
      )
      : nil
    )
  }
}
