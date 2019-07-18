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
  
  @Published var viewModel = CommandsViewModel()

  var service = CoreDataService(data: DataAssets.Commands.value)!
  
  private var _willChange = PassthroughSubject<Void, Never>()
  
  var willChange: AnyPublisher<Void, Never> {
    return _willChange.share().eraseToAnyPublisher()
  }
  
  var serviceCancelable: Cancellable?
  func onAppear() {
    _ = service.startup()
      .replaceError(with: [])
      .sink{ _ in }
    serviceCancelable = service.$commands
      .share()
      .sink(receiveValue: { commands in
        let commandKeys = commands.map { CommandKeys(command: $0) }
        self._willChange.send(())
        self.viewModel  = CommandsViewModel(commands: commandKeys)
      })
  }
  
}

struct CommandsViewModel {
  struct Text {
    static let forAll = "For all commands hold them until you see the screen change from black to "
    static let appleSupportRootUrlString = "https://support.apple.com/en-us/HT201255"
    static let appleSupportRootUrl: URL = {
      return URL(string: CommandsViewModel.Text.appleSupportRootUrlString)!
    }()
  }
  
  var commands: [CommandKeys] = []

}

struct CommandKeys: Hashable, Codable, Identifiable {
  
  var id: String {
    return title
  }
  
  let title: String
  let body: String
  let images: [DisplayImage]
  let keys: [KeyboardKey]
  let language: String?
  let urlString: String?
  
  var allKeys: String {
    keys.map{$0.key}.joined(separator: ", ")
  }
  
  init(title: String,
       body: String,
       images: [DisplayImage],
       keys: [KeyboardKey],
       language: String? = nil,
       urlString: String? = nil ){
    self.title = title
    self.body = body
    self.images = images
    self.keys = keys
    self.language = language
    self.urlString = urlString
  }
  
  init(command: Command) {
    
    self.title = command.title ?? ""
    self.body = command.body ?? ""
    self.language = command.language
    self.urlString = nil //TODO
    
    if let images = command.images as? [String] {
      self.images = images.map { imgName -> DisplayImage in
        return DisplayImage(systemName: imgName)
      }
    } else {
      self.images = []
    }
    if let keys = command.keys as? [String] {
      self.keys = keys.map{ key -> KeyboardKey in
        KeyboardKey(stringLiteral: key)
      }
    } else {
      self.keys = []
    }
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
