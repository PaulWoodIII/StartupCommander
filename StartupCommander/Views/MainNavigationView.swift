//
//  MainNavigationView.swift
//  StartupCommander
//
//  Created by Paul Wood on 6/24/19.
//  Copyright © 2019 Paul Wood. All rights reserved.
//

import SwiftUI

struct MainNavigationView : View {
  
  @EnvironmentObject var commandsPresenter: CommandsPresenter
  @EnvironmentObject var errorPresenter: ErrorPresenter
  
  var body: some View {
    ZStack {
      NavigationView {
        ContentView(viewModel: commandsPresenter.viewModel)
      }
      //ToastView(viewModel: errorPresenter.viewModel)
    }.onAppear(perform: commandsPresenter.onAppear)
  }
}

#if DEBUG
struct MainNavigationView_Previews : PreviewProvider {
  static var previews: some View {
    MainNavigationView()
      .modifier(iPhoneEnvironment())
  }
}
#endif
