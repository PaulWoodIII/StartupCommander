//
//  CommandKeyDetail.swift
//  StartupCommander
//
//  Created by Paul Wood on 6/24/19.
//  Copyright © 2019 Paul Wood. All rights reserved.
//

import SwiftUI

struct CommandKeyDetail : View {
    
    let command: CommandKeys
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    ForEach(command.images) { (displayImage: DisplayImage) in
                        Image(systemName: displayImage.systemName)
                            .padding([.top, .trailing])
                            .font(.title)
                    }
                }
                
                Text("Press Keys: " + command.allKeys)
                    .font(.body)
                
                Divider()
                
                Text(command.body)
                    .font(.body)
                
                Spacer()
            }
        }
        .padding()
        .navigationBarTitle(Text(command.title))
    }
}

#if DEBUG
struct CommandKeyDetail_Previews : PreviewProvider {
    static var previews: some View {
        NavigationView{
            CommandKeyDetail(command: Commander.commands[3])
        }
    }
}
#endif
