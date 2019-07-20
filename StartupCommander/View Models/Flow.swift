//
//  Flow.swift
//  StartupCommander
//
//  Created by Paul Wood on 7/19/19.
//  Copyright © 2019 Paul Wood. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class Flow {
  
  var navigationLink: DynamicNavigationDestinationLink<Flow.RootNavigation, Flow.RootNavigation, AnyView>?
  
  /// Modals that can be presented
  enum Sheet: Identifiable, Hashable {
    var id: Int {
      return self.hashValue
    }
    
    case about
    case email(_: EmailSender.Config)
    case url(_: URL)
    
    var view: AnyView {
      switch self {
      case .about:
        return SettingsView().typeErased
      case .email(let config):
        return NavigationView {
          EmailSender(config: config)
        }.typeErased
      case .url(let url):
        return SafariContainerView(url: url).typeErased
      }
    }
  }
  
  // TODO: Use with Dynamic Links for Deep linking
  enum RootNavigation: Identifiable, Hashable {
    var id: Int {
      return self.hashValue
    }
    
    case root
    case detail(_: CommandKeys)
  }
}
