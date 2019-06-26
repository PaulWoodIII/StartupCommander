//
//  CommandRow.swift
//  StartupCommander
//
//  Created by Paul Wood on 6/24/19.
//  Copyright © 2019 Paul Wood. All rights reserved.
//

import SwiftUI

struct CommandRow : View {
    
    let command: CommandKeys
    
    var body: some View {
        NavigationButton(destination: CommandKeyDetail(command: command)) {
            HStack {
                VStack(alignment: .leading) {
                    
                    HStack {
                        ForEach(command.images) { (displayImage: DisplayImage) in
                            Image(systemName: displayImage.systemName)
                                .padding([.top, .trailing])
                                .font(.title)
                        }
                    }
                    
                    Text(command.title)
                        .font(.headline)

                    Text("Press Keys: " + command.allKeys)
                        .font(.body)
                }
                
                Spacer()
                
            }
        }
    }
}

#if DEBUG
struct CommandRow_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            CommandRow(command: Commander.commands[0])
             .previewLayout(.sizeThatFits)
            CommandRow(command: Commander.commands[3])
//             .previewLayout(.fixed(width: 300, height: 150))
        }
    }
}
#endif
