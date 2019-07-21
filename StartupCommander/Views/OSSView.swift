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
  
  
  var body: some View {
    VStack {
      HStack {
        Text("This application uses some great Open Soure Software tools using Swift Package Manager")
          .lineLimit(.max)
          .font(.body)
        Image(systemSymbol: SFSymbol.chevronLeftSlashChevronRight)
          .font(.title)
      }.padding()
      
      Divider()
      
      List(OSSDataStore.licences) { software in
        NavigationLink(destination: OSSDetailView(software: software)) {
          VStack(alignment: .leading) {
            
            Text(software.title)
              .font(.headline)
              .lineLimit(.max)
            
            Text(software.licenseSlug)
              .lineLimit(.max)
              .font(.subheadline)
            
            Text(software.copyrightHolder)
              .lineLimit(.max)
              .font(.subheadline)
          }
        }
      }.listStyle(.plain)
    }.navigationBarTitle(Text("Open Source Software"))
  }
}

#if DEBUG

import SafePreviewDevices

struct OSSView_Previews : PreviewProvider {
  static var previews: some View {
    NavigationView {
      OSSView()
    }.previewDevice("iPhone XR")
  }
}
#endif

struct OSSDetailView: View {
  
  var software: OSSDependency
  
  var body: some View {
    VStack(alignment: .leading) {
      Text(software.license)
        .lineLimit(.max)
        .font(.caption)
        .padding()
        .frame(minWidth: 0, idealWidth: UIScreen.screens.first?.bounds.width, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
    }.navigationBarTitle(Text(software.title))
  }
}
