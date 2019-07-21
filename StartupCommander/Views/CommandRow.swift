//
//  CommandRow.swift
//  StartupCommander
//
//  Created by Paul Wood on 6/24/19.
//  Copyright © 2019 Paul Wood. All rights reserved.
//

import SwiftUI
import Combine

struct CommandRow : View {
  
  let command: CommandKeys
//  let link: DynamicNavigationDestinationLink<Flow.RootNavigation, Flow.RootNavigation, AnyView>?
//  let rootNavigation: PassthroughSubject<Flow.RootNavigation?, Never>
  
  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        ForEach(command.images) { (displayImage: DisplayImage) in
          Image(systemName: displayImage.systemName)
            .padding([.top, .trailing])
            .font(.title)
        }
      }
      Text(command.title)
        .font(.headline)
      .scaledToFill()
      Text("Press Keys: " + command.allKeys)
        .font(.body)      
    }
//    .tapAction {
//      self.link?.presentedData?.value = .detail(self.command)
//      self.rootNavigation.send()
//    }
    .lineLimit(nil)
  }
}

#if DEBUG
struct CommandRow_Previews : PreviewProvider {
  static var previews: some View {
    NavigationView {
      List(CommandKeyDebug.commands) { command in
        CommandRow(command: command)
//                   link: nil)
//                   rootNavigation: PassthroughSubject<Flow.RootNavigation?, Never>())
      }.navigationBarTitle("Command Row Tests")
    }
  }
}
#endif
