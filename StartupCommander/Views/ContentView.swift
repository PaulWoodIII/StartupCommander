//
//  ContentView.swift
//  StartupCommander
//
//  Created by Paul Wood on 6/24/19.
//  Copyright © 2019 Paul Wood. All rights reserved.
//

import SwiftUI
import UIKit

struct ContentView : View {
    
    var body: some View {
        VStack {
            Text(Commander.forAll)
                .multilineTextAlignment(.leading)
                .font(.title)
                .lineLimit(.none)
                .padding(.all)
            
            Divider()
                .padding(.top)
            
            List(Commander.commands) { (command: CommandKeys) in
                CommandRow(command: command)
            }
        }
        .navigationBarTitle(Text("Startup Commander"))
            .navigationBarItems(leading:
                PresentationButton(destination: SettingsView() ) {
                    Image(systemName: "gear")
                },
                                trailing:
            PresentationButton(destination: SafariContainerView(url: Commander.appleSupportRootUrl)) {
                Text(" Support")
            }
        )

    }
    
    func supportPressed() {

    }
    
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
    }
}
#endif
