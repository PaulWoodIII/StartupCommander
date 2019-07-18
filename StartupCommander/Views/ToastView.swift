//
//  ToastView.swift
//  StartupCommander
//
//  Created by Paul Wood on 7/11/19.
//  Copyright © 2019 Paul Wood. All rights reserved.
//

import SwiftUI

/// View that animates from the top of the screen and notifies the user of something,
/// the user can click the indicator or pull and drag the view down to reveal more content
struct ToastView : View {
  
  enum DisplayState {
    case hidden
    case peak
    case full
  }
  
  var viewModel: DisplayableErrorViewModel?
  
  let bounds = UIScreen.main.bounds
  
  var displayState: DisplayState = .full
  
  var body: some View {
    ZStack{
      
      Rectangle()
        .foregroundColor(Color(.Orange))
        .edgesIgnoringSafeArea(.all)
        .frame(
          minWidth: 0,
          maxWidth: .infinity,
          minHeight: 150,
          maxHeight: displayState != .full ? nil : .infinity,
          alignment: .top
      )
      
      VStack(alignment: .leading) {
        
        HStack (alignment: .firstTextBaseline){
          
          Image(systemSymbol: .exclamationmarkIcloud)
            .font(.title)
            .scaledToFill()
          
          Text(viewModel?.title ?? "")
            .font(.largeTitle)
            .lineLimit(1)
        }
        .frame(alignment: .topLeading)
          .padding([.top, .horizontal])
          .foregroundColor(.white)
        
        SubtitleView(subtitle: viewModel?.subtitle ?? "")
        
        if displayState == .full {
          Text("Sample Text, this could be a long explaination of the error, or instructions on ways to fix the problem that the app cannot perform itself")
            .foregroundColor(.white)
            .font(.body)
            .lineLimit(nil)
            .padding(.horizontal)
            .transition(AnyTransition.move(edge: .bottom).combined(with: .opacity))
            .frame(minWidth: 0, maxWidth: .infinity,
                   minHeight: 0, maxHeight: .infinity,
                   alignment: .topLeading)
        }
        
        TabbedViewBottom()
          .frame( minHeight: 0, maxHeight:  .infinity, alignment: .bottom)
          .edgesIgnoringSafeArea(.all)
      }.frame(
        minWidth: 0,
        maxWidth: .infinity,
        minHeight: 0,
        maxHeight: .infinity,
        alignment: .topLeading
      ).animation(.spring())
      
      
      
      
    }
  }
  
}

#if DEBUG

class EmptyErrorhandler: ErrorHandler {
  
}

struct ToastView_Previews : PreviewProvider {
  static var previews: some View {
    Group {
      ZStack {
        NavigationView {
          Text("Preview View")
        }
        ToastView(viewModel: DisplayableErrorViewModel(title: "Title",
                                                       subtitle: "Subtitle",
                                                       errorHandler: EmptyErrorhandler()))
      }
      ZStack {
        ToastView(viewModel: nil)
        NavigationView {
          Text("Preview View")
        }
      }
    }
    
  }
}
#endif


extension AnyTransition {
  static var moveInto: AnyTransition {
    let insertion = AnyTransition.move(edge: .trailing)
      .combined(with: .opacity)
    return insertion
  }
}

struct SubtitleView : View {
  
  var subtitle: String
  
  var body: some View {
    return Text(self.subtitle)
      .font(.body)
      .lineLimit(2)
      .padding([.horizontal])
      .foregroundColor(.white)
      .frame(alignment: .topLeading)
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
    }.padding(.bottom, 10)
  }
}
