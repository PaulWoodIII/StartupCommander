//
//  CommandRow.swift
//  StartupCommander
//
//  Created by Paul Wood on 6/24/19.
//  Copyright © 2019 Paul Wood. All rights reserved.
//

import SwiftUI

struct CommandRow : View {
  
  let command: CommandKeys
  
  var body: some View {
    NavigationLink(destination: CommandKeyDetail(command: command)) {
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
    }
    .lineLimit(nil)
  }
}

#if DEBUG
struct CommandRow_Previews : PreviewProvider {
  static var previews: some View {
    NavigationView {
      List(Commander.testCommands) { command in
        CommandRow(command: command)
      }.navigationBarTitle("Command Row Tests")
    }
  }
}
#endif
