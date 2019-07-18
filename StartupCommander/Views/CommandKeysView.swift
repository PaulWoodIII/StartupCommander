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
  
  enum SheetOptions: Identifiable {
    
    case about
    case appleSupport

    var id: Int {
          return self.hashValue
        }
    
    var view: some View {
      switch self {
      case .about:
        return SettingsView().typeErased
      case .appleSupport:
        return SafariContainerView(url: DisplayText.appleSupportRootUrl).typeErased
      }
    }
  }
  
  var sheetSelection: State<SheetOptions?> = State(initialValue: nil)
  
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
    }.sheet(item: sheetSelection.binding,
            onDismiss: { self.sheetSelection.value = nil },
            content: { sheetSelection in
              return sheetSelection.view
    }).navigationBarTitle(Text("Startup Commander"))
      .navigationBarItems(leading: gearButton, trailing:appleSupportButton)
  }
  
  var gearButton : some View {
    Button(action: {
      self.sheetSelection.value = .about
    }, label: {
      Image(systemName: "gear")
        .accentColor(.blue)
        .imageScale(.large)
        .accessibility(label: Text("About and Help"))
        .padding()
    })
  }
  
  var appleSupportButton: some View {
    
    Button( action: {
      self.sheetSelection.value = .appleSupport
    }, label: {
      Text(" Support")
        .accessibility(label: Text("Apple Support"))
        .padding()
    })
    
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
