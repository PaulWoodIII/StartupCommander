//
//  AnchorAtTop.swift
//  StartupCommander
//
//  Created by Paul Wood on 7/12/19.
//  Copyright © 2019 Paul Wood. All rights reserved.
//

import SwiftUI

struct AnchorAtTop : View {
    var body: some View {
      VStack(alignment: .leading){
        Text("Hello World!")
          .background(Color.yellow)
      }.frame(minWidth: 0, maxWidth: .infinity,
              minHeight: 0, maxHeight: .infinity,
              alignment: .topLeading)
    }
}

#if DEBUG
struct AnchorAtTop_Previews : PreviewProvider {
    static var previews: some View {
        AnchorAtTop()
    }
}
#endif
