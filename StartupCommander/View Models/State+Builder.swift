//
//  State+Builder.swift
//  StartupCommander
//
//  Created by Paul Wood on 7/18/19.
//  Copyright © 2019 Paul Wood. All rights reserved.
//

import Foundation

protocol Builder {}
extension Builder {
    func set<T>(_ keyPath: WritableKeyPath<Self, T>, _ value: T) -> Self {
        var copy = self
        copy[keyPath: keyPath] = value
        return copy
    }
}
