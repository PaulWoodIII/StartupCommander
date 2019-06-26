//
//  DataAssets.swift
//  StartupCommander
//
//  Created by Paul Wood on 6/26/19.
//  Copyright © 2019 Paul Wood. All rights reserved.
//

import Foundation
import UIKit

enum DataAssets: String {
    case Commands = "Commands"
}

extension DataAssets {
    var value: Data {
        let asset = NSDataAsset(name: "Commands", bundle: Bundle.main)
        return asset!.data
    }
}
