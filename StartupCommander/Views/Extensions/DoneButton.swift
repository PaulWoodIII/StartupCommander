//
//  DoneButton.swift
//  StartupCommander
//
//  Created by Paul Wood on 7/9/19.
//  Copyright © 2019 Paul Wood. All rights reserved.
//

import SwiftUI

struct DoneButton : View {
  
  let action: () -> Void
  
  var body: some View {
    Button("Done", action: action)
  }
}

#if DEBUG
struct DoneButton_Previews : PreviewProvider {
    static var previews: some View {
      DoneButton(){}
    }
}
#endif
