//
//  MainNavigationView.swift
//  StartupCommander
//
//  Created by Paul Wood on 6/24/19.
//  Copyright © 2019 Paul Wood. All rights reserved.
//

import SwiftUI
import CombineFeedback
import CombineFeedbackUI

struct MainNavigationView : View {
  
  @EnvironmentObject var errorPresenter: ErrorPresenter
  
  var body: some View {
    ZStack {
      NavigationView {
        Widget(
            viewModel: CommandsViewModel(),
            render: CommandKeysView.init
        )
        //ContentView(viewModel: commandsPresenter.viewModel)
      }
      //ToastView(viewModel: errorPresenter.viewModel)
    }
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
