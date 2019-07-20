//
//  ErrorViewModel.swift
//  StartupCommander
//
//  Created by Paul Wood on 7/11/19.
//  Copyright © 2019 Paul Wood. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

protocol ErrorHandler {
  
}

class ErrorViewModel: BindableObject, ErrorHandler {
  
  private var displayQueue: [DisplayableError] = []
  
  @Published var viewModel: DisplayableErrorViewModel? = nil

  #if DEBUG
  var loopErrors: Bool = false
  init(loopErrors: Bool){
    self.loopErrors = loopErrors
    loopErrorCreation()
  }
  #endif
  
  var willChange = PassthroughSubject<Void, Never>()
  
  #if DEBUG
  var makeErrors: Cancellable?
  func loopErrorCreation() {
    guard loopErrors else { return }

    makeErrors = Timer.publish(every: 1, on: RunLoop.current, in: .default)
      .autoconnect()
      .sink(receiveValue: { _ in
          self.willChange.send(())
          if self.viewModel == nil {
          self.viewModel = DisplayableErrorViewModel(title: "Error",
                                                     subtitle: "Subtitle",
                                                     body: "Body String",
                                                     errorHandler: self)
          } else {
            self.viewModel = nil
          }
        })
  }
  #endif
}

struct DisplayableErrorViewModel {
  var title: String
  var subtitle: String
  var body: String
  var errorHandler: ErrorHandler
  var userSelected: Bool = false
}

struct DisplayableError: Error {
  
}
