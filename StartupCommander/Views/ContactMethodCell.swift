//
//  ContactMethodCell.swift
//  StartupCommander
//
//  Created by Paul Wood on 6/26/19.
//  Copyright © 2019 Paul Wood. All rights reserved.
//

import SwiftUI
import UIKit

struct ContactMethodCell : View {
    let contactInfo: ContactInfo
    var body: some View {
        if contactInfo.urlString.starts(with: "http") {
            return PresentationButton(destination: SafariContainerView(url: contactInfo.url)) {
                Text(contactInfo.type + ": " + contactInfo.value)
            }.typeErased
        } else {
            return Button(action: {
                if UIApplication.shared.canOpenURL(self.contactInfo.url) {
                    UIApplication.shared.open(self.contactInfo.url, options: [:], completionHandler: nil)
                }
            }) {
                Text(contactInfo.type + ": " + contactInfo.value).typeErased
            }.typeErased
            
        }
        
    }
}

#if DEBUG
struct ContactMethodCell_Previews : PreviewProvider {
    static var previews: some View {
        let resume = Resume()
        return ContactMethodCell(contactInfo: resume.contact[0] )
    }
}
#endif

