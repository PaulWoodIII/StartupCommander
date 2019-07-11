//
//  CommandsPresenter.swift
//  StartupCommander
//
//  Created by Paul Wood on 7/9/19.
//  Copyright © 2019 Paul Wood. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class CommandsPresenter: BindableObject {
  
  
  @Published var viewModel: [CommandKeys] = []
  
  private var _didChange = PassthroughSubject<Void, Never>()
  
  var didChange: AnyPublisher<Void, Never> {
    return _didChange
      .receive(on: RunLoop.main)
      .eraseToAnyPublisher()
  }
  
}


struct CommandKeys: Hashable, Codable, Identifiable {
  
  var id: String {
    return title
  }
  
  let images: [DisplayImage]
  let title: String
  let keys: [KeyboardKey]
  let body: String
  let lanaguage: String = "en-US"
  let urlString: String? = nil
  
  var allKeys: String {
    keys.map{$0.key}.joined(separator: ", ")
  }
}

struct KeyboardKey: Identifiable, ExpressibleByStringLiteral, Hashable, Codable {
  
  public var id: String { return key }
  
  init(stringLiteral value: String) {
    self.key = value
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let value = try container.decode(String.self)
    self.init(stringLiteral: value)
  }
  
  var key: String
}

struct DisplayImage: Hashable, Codable, Identifiable {
  let systemName: String
  var id: String {
    return systemName
  }
}
