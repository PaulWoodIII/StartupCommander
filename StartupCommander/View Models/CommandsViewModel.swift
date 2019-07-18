//
//  CommandsViewModel.swift
//  StartupCommander
//
//  Created by Paul Wood on 7/9/19.
//  Copyright © 2019 Paul Wood. All rights reserved.
//

import Foundation
import Combine
import CombineFeedback
import CombineFeedbackUI
import SwiftUI

class CommandsViewModel: ViewModel<CommandsViewModel.State, CommandsViewModel.Event>  {
  
  struct State: Builder {
    var status: Status = .initial
    var commands: [CommandKeys] = []
    var serviceCancelable: Cancellable?
    
    struct Text {
      static let forAll = "For all commands hold them until you see the screen change from black to "
      static let appleSupportRootUrlString = "https://support.apple.com/en-us/HT201255"
      static let appleSupportRootUrl: URL = {
        return URL(string: Text.appleSupportRootUrlString)!
      }()
    }
  }
  
  enum Event {
    case initalized
    case monitorWith(_: Cancellable)
    case didLoad(_: [CommandKeys])
    case didFail(_: CoreDataService.Error)
  }
  
  enum Status: Equatable {
    case initial
    case loading
    case idle
    case failed(NSError)
  }
  
  init(initial: State = State()) {
    super.init(
      initial: initial,
      feedbacks: [
        CommandsViewModel
          .monitorStore(commandsPublisher: CoreDataService.shared.$commands.eraseToAnyPublisher()),
        CommandsViewModel
          .startup(coreDataService: CoreDataService.shared.startup)
      ],
      scheduler: RunLoop.main,
      reducer: CommandsViewModel.reduce
    )
  }
  static func startup(coreDataService startup: @escaping () -> AnyPublisher<Bool, CoreDataService.Error>) -> Feedback<State, Event> {
    return Feedback(predicate: { (state: CommandsViewModel.State) -> Bool in
      return state.status == Status.initial
    }, effects: { (state: CommandsViewModel.State) -> AnyPublisher<Event, Never> in
      return startup().map{ _ in }
        .map({_ in
          return Event.initalized
        }).catch({ error in
          return Just(Event.didFail(error)).eraseToAnyPublisher()
        })
        .eraseToAnyPublisher()
    })
  }
  
  static func monitorStore(commandsPublisher: AnyPublisher<[Command], Never> ) -> Feedback<State, Event> {
    return Feedback(predicate: { (state: CommandsViewModel.State) -> Bool in
      return state.serviceCancelable == nil
    }, effects: { (state: CommandsViewModel.State) -> AnyPublisher<Event, Never> in
      let monitor = commandsPublisher
        .map { (commands: [Command]) -> [CommandKeys] in
          return commands.map(CommandKeys.init(command:))
      }.removeDuplicates()
        .map { commandKeys in
          Event.didLoad(commandKeys)
      }
      let serviceObservable = monitor.makeConnectable().connect()
      return monitor.prepend(Event.monitorWith(serviceObservable)).eraseToAnyPublisher()
    })
  }
  
  private static func reduce(state: State, event: Event) -> State {
    switch event {
    case .didLoad(let commandKeys):
      return state.set(\.commands, commandKeys)
    case .initalized:
      return state.set(\.status, .loading)
    case .monitorWith(let cancellable):
      return state.set(\.serviceCancelable, cancellable)
    default:
      return state
    }
  }
}

struct CommandKeys: Equatable, Hashable, Codable, Identifiable {
  
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
