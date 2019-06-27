//
//  OSSView.swift
//  StartupCommander
//
//  Created by Paul Wood on 6/25/19.
//  Copyright © 2019 Paul Wood. All rights reserved.
//

import SwiftUI
import SFSafeSymbols
struct OSSView : View {
    
    @EnvironmentObject var ossDataStore: OSSDataStore
    
    var body: some View {
        VStack {
            HStack {
                Image(systemSymbol: SFSymbol.chevronLeftSlashChevronRight)
                    .font(.title)
                Text("This application uses some great Open Soure Software tools using Swift Package Manager")
                    .lineLimit(.max)
                    .font(.body)
                Image(systemSymbol: SFSymbol.chevronLeftSlashChevronRight)
                    .font(.title)
            }
            
          
            
            List(ossDataStore.licences) { software in
                VStack(alignment: .leading) {
                    Text(software.title)
                        .font(.title)
                        .lineLimit(.max)
                    Text(software.license)
                        .font(.caption)
                        .lineLimit(.max)
                }
            }
        }.navigationBarTitle(Text("Open Source Software"))

        
    }
}

#if DEBUG
struct OSSView_Previews : PreviewProvider {
    static var previews: some View {
        NavigationView {
            OSSView().environmentObject(OSSDataStore())
        }
    }
}
#endif
