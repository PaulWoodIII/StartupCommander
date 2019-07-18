//
//  CommandKeysView.swift
//  StartupCommander
//
//  Created by Paul Wood on 6/24/19.
//  Copyright © 2019 Paul Wood. All rights reserved.
//

import SwiftUI
import UIKit
import CombineFeedback
import CombineFeedbackUI

struct CommandKeysView : View {
  
  typealias CommandsState = CommandsViewModel.State
  typealias DisplayText = CommandsViewModel.State.Text
  typealias Event = CommandsViewModel.Event
  
  private let context: Context<CommandsState, Event>
  
  init(context: Context<CommandsState, Event>) {
    self.context = context
  }
  
  var isAboutShown: State<Bool> = State(initialValue: false)
  var isAppleSupportShown: State<Bool> = State(initialValue: false)
  
  var body: some View {
      VStack {
        Text(DisplayText.forAll)
          .multilineTextAlignment(.leading)
          .font(.title)
          .lineLimit(.max)
          .padding(.all)
        
        Divider()
          .padding(.top)
        
        List(context.commands) { (command: CommandKeys) in
          CommandRow(command: command)
        }
      }
        //    .presentation( isAboutShown ? settingsModal : nil)
        //      .presentation( isAppleSupportShown ? appleSupportModal : nil)
        .navigationBarTitle(Text("Startup Commander"))
        .navigationBarItems(leading:
          
          //TODO: Change
          PresentationLink2(destination: SettingsView() ) {
            Image(systemName: "gear")
              .accentColor(.blue)
              .imageScale(.large)
              .accessibility(label: Text("About and Help"))
              .padding()
          },
                            trailing:
          //TODO: Change
          PresentationLink2(destination: SafariContainerView(url: DisplayText.appleSupportRootUrl)) {
            Text(" Support")
              .accessibility(label: Text("Apple Support"))
              .padding()
          }
      )
  }
  
  var gearButton : some View {
    Button(action: {
      self.isAboutShown.value = true
    }, label: {
      Image(systemName: "gear")
        .imageScale(.large)
        .accessibility(label: Text("About and Help"))
        .padding()
    })
  }
  
  var settingsModal: Modal {
    Modal(SettingsView())
  }
  
  var appleSupportButton: some View {
    
    Button( action: {
      self.isAppleSupportShown.value = true
    }, label: {
      Text(" Support")
        .accessibility(label: Text("Apple Support"))
        .padding()
    })
    
  }
  
  var appleSupportModal: Modal {
    Modal(SafariContainerView(url: DisplayText.appleSupportRootUrl))
  }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
  static var previews: some View {
    NavigationView {
      Widget(
        viewModel: CommandsViewModel(),
        render: CommandKeysView.init
      )
    }.modifier(iPhoneEnvironment())
  }
}
#endif
