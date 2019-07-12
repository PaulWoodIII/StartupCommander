//
//  AnimatedButton.swift
//  StartupCommander
//
//  Created by Paul Wood on 7/11/19.
//  Copyright © 2019 Paul Wood. All rights reserved.
//

import SwiftUI

struct AnimatedButton : View {
  
  @State var isAnimating: Bool = false
  
  var body: some View {
    Button(action: {
      self.isAnimating.toggle()
    }) {
      Text("asdf")
    }.foregroundColor(Color.yellow)
      .padding()
      .background(Color(.Green))
      .cornerRadius(20)
      .animation(.spring())
      .scaleEffect(isAnimating ? 2.0 : 1.0)
  }
}

#if DEBUG
struct FunButton_Previews : PreviewProvider {
  static var previews: some View {
    VStack {
      AnimatedButton()
    }
  }
}
#endif
