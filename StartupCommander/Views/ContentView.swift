//
//  ContentView.swift
//  StartupCommander
//
//  Created by Paul Wood on 6/24/19.
//  Copyright © 2019 Paul Wood. All rights reserved.
//

import SwiftUI
import UIKit

struct ContentView : View {
  
  var body: some View {
    VStack {
      Text(Commander.forAll)
        .multilineTextAlignment(.leading)
        .font(.title)
        .lineLimit(.none)
        .padding(.all)
      
      Divider()
        .padding(.top)
      
      List(Commander.commands) { (command: CommandKeys) in
        CommandRow(command: command)
      }
    }
    .navigationBarTitle(Text("Startup Commander"))
      .navigationBarItems(leading:
        
        PresentationLink2(destination: SettingsView() ) {
          Image(systemName: "gear")
            .accentColor(.blue)
            .imageScale(.large)
            .accessibility(label: Text("About and Help"))
            .padding()
        },
                          trailing:
        PresentationLink2(destination: SafariContainerView(url: Commander.appleSupportRootUrl)) {
          Text(" Support")
            .accessibility(label: Text("Apple Support"))
            .padding()
        }
    )
  }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
  static var previews: some View {
    NavigationView {
      ContentView()
    }
  }
}
#endif
