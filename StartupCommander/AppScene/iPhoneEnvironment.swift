//
//  iPhoneEnvironment.swift
//  StartupCommander
//
//  Created by Paul Wood on 6/26/19.
//  Copyright © 2019 Paul Wood. All rights reserved.
//

import SwiftUI

struct Environment {
  static let shared = Environment()
  let commander = CommandsPresenter()
  let errorPresenter = ErrorPresenter(loopErrors: true)
}

struct iPhoneEnvironment: ViewModifier {
  
    func body(content: Content) -> some View {
        content
            .environmentObject(Environment.shared.commander)
            .environmentObject(Environment.shared.errorPresenter)
    }
}
