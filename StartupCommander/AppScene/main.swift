//
//  main.swift
//  StartupCommander
//
//  Created by Paul Wood on 7/9/19.
//  Copyright © 2019 Paul Wood. All rights reserved.
//

import Foundation
import UIKit

let appDelegateClass: AnyClass = NSClassFromString("TestingAppDelegate") ?? AppDelegate.self
UIApplicationMain(
  CommandLine.argc,
  CommandLine.unsafeArgv,
  nil,
  NSStringFromClass(appDelegateClass)
)
