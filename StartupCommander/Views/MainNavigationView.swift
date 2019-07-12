//
//  MainNavigationView.swift
//  StartupCommander
//
//  Created by Paul Wood on 6/24/19.
//  Copyright © 2019 Paul Wood. All rights reserved.
//

import SwiftUI

struct MainNavigationView : View {
  
  
  var body: some View {
    ZStack {
      NavigationView {
        ContentView()
      }
      ToastView(title: "Error",
                subtitle: "looks like thunderstorms in the cloud")
      
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
