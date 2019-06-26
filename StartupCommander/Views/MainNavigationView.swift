//
//  MainNavigationView.swift
//  StartupCommander
//
//  Created by Paul Wood on 6/24/19.
//  Copyright © 2019 Paul Wood. All rights reserved.
//

import SwiftUI

struct MainNavigationView : View {
    var body: some View {
        NavigationView {
            ContentView()
        }
        
        
    }
}

#if DEBUG
struct MainNavigationView_Previews : PreviewProvider {
    static var previews: some View {
        MainNavigationView()
    }
}
#endif
