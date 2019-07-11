//
//  CommandKeyDetail.swift
//  StartupCommander
//
//  Created by Paul Wood on 6/24/19.
//  Copyright © 2019 Paul Wood. All rights reserved.
//

import SwiftUI

struct CommandKeyDetail : View {
  
  let command: CommandKeys
  
  fileprivate func keyImageView() -> some View  {
    return HStack {
      ForEach(command.images) { (displayImage: DisplayImage) in
        Image(systemName: displayImage.systemName)
          .padding([.top, .trailing])
          .font(.title)
      }
    }
  }
  
  var body: some View {
    ScrollView {
      VStack(alignment: .leading) {
        keyImageView()
        Text(command.title)
          .lineLimit(.none)
          .font(.headline)
        Divider()
        Text(command.body)
          .lineLimit(.max)
          .font(.body)
      }
    }
    .padding()
    .navigationBarTitle(Text(command.allKeys))
  }
}

#if DEBUG
struct CommandKeyDetail_Previews : PreviewProvider {
  static var previews: some View {
    NavigationView{
      CommandKeyDetail(command: CommandKeyDebug.commands[7])
    }
  }
}
#endif
