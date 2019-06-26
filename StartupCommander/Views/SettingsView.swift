//
//  SettingsView.swift
//  StartupCommander
//
//  Created by Paul Wood on 6/25/19.
//  Copyright © 2019 Paul Wood. All rights reserved.
//

import SwiftUI

struct SettingsView : View {
    var body: some View {
        NavigationView {
            
            Form {

                Section(header: Text("⚙️")) {
                    Text("A simple App by Paul Wood")
                        .font(.headline)
                        .lineLimit(2)
                    Text("This app is designed to help you when your Mac needs to be rebooted in a special way. I often go to the Apple Support documentations or Stack Overflow when I need to remember these commands but this has happened often enough when I have no internet access that having that information cached on my phone would help")
                        .font(.body)
                        .lineLimit(.max)

                }
                
                Section(header: Text("💸➡️👨‍💻➡️📱➡️💸")) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("You can hire me")
                                .font(.headline)
                                .multilineTextAlignment(.leading)
                                .lineLimit(2)
                            Text("11 years of experience on the platform might be what your project needs right now.")
                                .font(.body)
                                .lineLimit(.max)

                        }
                        Spacer()
                        Button(action: emailAction) {
                            Text("Email")
                        }
                    }

                }
                
                Section(header: Text("🤗")) {
                    
                    NavigationButton(destination: AboutPaulView()){

                    HStack {
                        Text("About the Author")
                            .font(.headline)
                        }
                        
                    }
                    
                    NavigationButton(destination: OSSView()){

                        HStack {
                            Text("Open-Source Software")
                                .font(.headline)
                        }
                    }
                }
                
                Section(header: Text("📫")) {
                    
                    HStack{
                        Text("Send Feedback")
                            .font(.headline)

                        Spacer()
                        Button(action: emailAction) {
                            Text("Email")
                        }
                        }.tapAction(emailAction)
                    
                    HStack{
                        VStack(alignment: .leading) {
                            Text("Rate this Application")
                                .font(.headline)
                            Text("Any kind of feedback would be helpful but a great review is probabaly the best kind of feedback")
                                .lineLimit(.max)
                                .font(.body)
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                        }.tapAction(emailAction)
                    
                }
                
            }
            .navigationBarTitle(Text("About and Help"))
            
        }
    }
    
    func emailAction() -> Void {
        
    }
}

#if DEBUG
struct SettingsView_Previews : PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
#endif
