//
//  ToastBox.swift
//  StartupCommander
//
//  Created by Paul Wood on 7/11/19.
//  Copyright © 2019 Paul Wood. All rights reserved.
//

import SwiftUI

/// Tried to make my own Rectangle Shape it worked just like I expected!
struct ToastBox: Shape {
  func path(in rect: CGRect) -> Path {
    let width: CGFloat = rect.size.width
    let height: CGFloat = rect.size.height
    let topLeft = CGPoint(x: 0, y: 0)
    let topRight = CGPoint(x: width, y: 0)
    let bottomRight = CGPoint(x: width, y: height)
    let bottomLeft = CGPoint(x: 0, y: height)
    let pathCorners = [topLeft, topRight, bottomRight, bottomLeft]
    var path = Path()
    path.move( to: CGPoint.zero)
    pathCorners.forEach { point in
      path.addLine( to: .init(x:point.x,y:point.y))
    }
    return path
  }
}

#if DEBUG
struct ToastBox_Previews : PreviewProvider {
    static var previews: some View {
        ToastBox()
    }
}
#endif
