//
//  Command+CommandKey.swift
//  StartupCommander
//
//  Created by Paul Wood on 7/9/19.
//  Copyright © 2019 Paul Wood. All rights reserved.
//

import Foundation
import CoreData

extension Command {
  
  static func create(_ context: NSManagedObjectContext,
                     commandKey: CommandKeys) -> Command {
    let command = Command(context: context)
    
    let stringKeys = commandKey.keys.map{$0.key}
    let images = commandKey.images.map{$0.systemName}
    
    command.body = commandKey.body
    command.keys = NSArray(array: stringKeys)
    command.title = commandKey.title
    command.images = NSArray(array: images)
    command.language = "en-US"
    return command
  }
}
