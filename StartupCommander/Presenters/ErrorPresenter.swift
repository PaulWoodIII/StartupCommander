//
//  ErrorPresenter.swift
//  StartupCommander
//
//  Created by Paul Wood on 7/11/19.
//  Copyright © 2019 Paul Wood. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class ErrorPresenter: BindableObject {
  
  private var displayQueue: [DisplayableError] = []
  
  @Published var shouldDisplay: Bool = false
  @Published var viewModel: DisplayableErrorViewModel? = nil
  
  var didChange = PassthroughSubject<Void, Never>()
  
  init() {
    loopErrorCreation()
  }
  
  deinit {
    print("This should never be destroyed outside of test")
  }
  
  var makeErrors: Cancellable?
  func loopErrorCreation() {
    makeErrors = Just<Void>(())
      .delay(for: 2, scheduler:RunLoop.main)
      .map({ _ in
        self.shouldDisplay = true
        self.didChange.send(())
      })
      .delay(for: 2, scheduler: RunLoop.main)
      .map({ _ in
        self.shouldDisplay = false
        self.didChange.send(())
      })
      .setFailureType(to: NSError.self)
      .tryMap({ _ in
        throw NSError()
      })
      .retry(.max)
      .sink(receiveValue: { _ in

      })
  }
  
}

struct DisplayableErrorViewModel {
  var wrappedError: DisplayableError?
  var title = "A title"
  var subtitle = "A title"
}

struct DisplayableError: Error {
  
}
