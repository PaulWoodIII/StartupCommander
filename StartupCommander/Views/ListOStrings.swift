//
//  ListOStrings.swift
//  StartupCommander
//
//  Created by Paul Wood on 6/26/19.
//  Copyright © 2019 Paul Wood. All rights reserved.
//

import SwiftUI

struct StringWrapper: Identifiable {
    var id = UUID()
    let value: String
}

struct ListOStrings : View {
    var strings: [StringWrapper]
    var body: some View {
        List (strings) { string in
            Text(string.value)
        }
    }
}

#if DEBUG
struct ListOStrings_Previews : PreviewProvider {
    static var previews: some View {
        ListOStrings(strings: [StringWrapper(value: "Paul"),
                               StringWrapper(value: "Ben")])
    }
}
#endif
