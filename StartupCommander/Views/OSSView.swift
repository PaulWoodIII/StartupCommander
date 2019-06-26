//
//  OSSView.swift
//  StartupCommander
//
//  Created by Paul Wood on 6/25/19.
//  Copyright © 2019 Paul Wood. All rights reserved.
//

import SwiftUI

struct OSSView : View {
    
    let ossBody = """
100% of this code is written by Paul Wood and currently is closed source until this view gets changed. Hopefully that will happen shortly
"""
    
    var body: some View {
        List {
            Text(ossBody)
                .lineLimit(.max)
        }
        
    }
}

#if DEBUG
struct OSSView_Previews : PreviewProvider {
    static var previews: some View {
        OSSView()
    }
}
#endif
