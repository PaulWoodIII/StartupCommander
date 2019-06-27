//
//  iPhoneEnvironment.swift
//  StartupCommander
//
//  Created by Paul Wood on 6/26/19.
//  Copyright © 2019 Paul Wood. All rights reserved.
//

import SwiftUI

struct iPhoneEnvironment: ViewModifier {
    func body(content: Content) -> some View {
        content
            .environmentObject(Resume())
            .environmentObject(Commander(data: DataAssets.Commands.value))
            .environmentObject(OSSDataStore())
    }
}
