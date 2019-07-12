//
//  ToastView.swift
//  StartupCommander
//
//  Created by Paul Wood on 7/11/19.
//  Copyright © 2019 Paul Wood. All rights reserved.
//

import SwiftUI

struct ToastView : View {
  
  @EnvironmentObject var errorPresenter: ErrorPresenter
  @State var isShowing: Bool = false
  var title: String
  var subtitle: String
  
  static let bounds = UIScreen.main.bounds
  
  var body: some View {
    
    VStack(alignment: .leading) {
      
      HStack (alignment: .firstTextBaseline){
        Image(systemSymbol: .exclamationmarkIcloud)
          .font(.title)
          .scaledToFill()

        Text(errorPresenter.viewModel?.title ?? "")
          .font(.largeTitle)
        .lineLimit(1)
        
        Spacer()
      }.frame(minWidth: 0, maxWidth: .infinity)
      .padding(.horizontal)
       .padding(.top)
       .foregroundColor(.white)
      
      SubtitleView(subtitle: errorPresenter.viewModel?.subtitle ?? "")
      TabbedViewBottom()
    }.background(Color.yellow)
      .offset(y: errorPresenter.shouldDisplay ? -376 : -536)
      .edgesIgnoringSafeArea(.top)
      .frame(idealWidth: ToastView.bounds.width,
             alignment: .topLeading)
      .animation(.spring())
//      .tapAction {
//        self.isShowing.toggle()
//      }
//    .onReceive(errorPresenter.didChange) {
//      self.isShowing = self.errorPresenter.shouldDisplay
//      self.isShowing = self.errorPresenter.viewModel != nil
//    }
  }
  
}

#if DEBUG
struct ToastView_Previews : PreviewProvider {
  static var previews: some View {
    MainNavigationView()
      .modifier(iPhoneEnvironment())
  }
}
#endif

struct SubtitleView : View {
  
  var subtitle: String
  
  var body: some View {
    return Text(self.subtitle)
      .font(.body)
      .lineLimit(2)
      .padding(.horizontal)
      .padding(.bottom)
      .foregroundColor(.white)
  }
}

struct TabbedViewBottom : View {
  var body: some View {
    return HStack(alignment: .center) {
      Spacer()
      RoundedRectangle(cornerRadius: 3)
        .foregroundColor(.gray)
        .frame(width: 60, height: 6, alignment: .center)
      Spacer()
    }.padding(.bottom, 5)
  }
}
