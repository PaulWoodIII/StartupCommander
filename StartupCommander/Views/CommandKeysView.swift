//
//  CommandKeysView.swift
//  StartupCommander
//
//  Created by Paul Wood on 6/24/19.
//  Copyright © 2019 Paul Wood. All rights reserved.
//

import SwiftUI
import UIKit
import Combine
import CombineFeedback
import CombineFeedbackUI

struct CommandKeysView : View {
  
  typealias CommandsState = CommandsViewModel.State
  typealias DisplayText = CommandsViewModel.State.Text
  typealias Event = CommandsViewModel.Event
  
  private let context: Context<CommandsState, Event>
  private let modalBinding: Binding<Flow.Sheet?>
  private let navBinding: Binding<Flow.RootNavigation?>
  private let navigation = PassthroughSubject<Flow.RootNavigation?, Never>()
  private let navCancel: Cancellable?
  private var navigationLink: DynamicNavigationDestinationLink<Flow.RootNavigation, Flow.RootNavigation, AnyView>
  
  init(context: Context<CommandsState, Event>) {
    self.context = context
    let navBinding = context.binding(for: \.rootNavigation) { value -> CommandKeysView.Event in
      if value != nil {
        return Event.link(value)
      } else {
        return Event.popNavigation
      }
    }
    self.navBinding = navBinding
    self.navigationLink =
      DynamicNavigationDestinationLink(
        id: \Flow.RootNavigation.self,
        content: { (destination: Flow.RootNavigation) -> AnyView? in
          
          switch destination {
          case .detail(let key):
            return CommandKeyDetail(command: key,
                                    rootNavigation: navBinding).typeErased
          case .root:
            context.send(event: .popNavigation)//TEST?
            return nil
          }
      })
    self.navigationLink.presentedData
    context.flow.navigationLink = self.navigationLink
    self.modalBinding = context.binding(for: \.rootSheet)

    navCancel = navigation.assign(to: \.value, on: navBinding)
  }
  

  
  var body: some View {
    VStack {
      Text(DisplayText.forAll)
        .multilineTextAlignment(.leading)
        .font(.title)
        .lineLimit(.max)
        .padding(.all)
      
      Divider()
        .padding(.top)
      
      List(context.commands) { (command: CommandKeys) -> CommandRow in
        CommandRow(command: command,
                   link: self.navigationLink)
      }
    }.navigationBarTitle(Text("Startup Commander"))
      .navigationBarItems(leading: gearButton, trailing:appleSupportButton)
      .sheet(
        item: modalBinding,
        onDismiss: {
          self.context.send(event: .popSheet)
      },
        content: { rootSheet in
          return rootSheet.view
      })
  }
  
  var gearButton : some View {
    Button(action: {
      self.context.send(event: .sheet(.about))
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
      let url = DisplayText.appleSupportRootUrl
      self.context.send(event: .sheet(.url(url)))
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
