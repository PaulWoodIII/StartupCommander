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
  let phoneCaller = PhoneCaller()
  
  @State var showURLModal = false
  @State var showEmailModal = false
  
  func contactAction() {
    
    if contactInfo.urlString.hasPrefix("http") {
      self.showURLModal.toggle()
    } else if contactInfo.urlString.hasPrefix("telprompt:") {
      let phoneNumber =
        String(contactInfo.urlString.dropFirst("telprompt:".count))
      phoneCaller.call(phoneNumber)
    } else if contactInfo.urlString.hasPrefix("mailto:") {
      showEmailModal.toggle()
    }
    
  }
  
  var body: some View {
    
    HStack {
      Text(contactInfo.type + ": ")
      Button(action: contactAction,
             label: {Text(contactInfo.value)})
    }
    .presentation( showURLModal && contactInfo.url != nil ? safariModal : nil)
      .presentation( showEmailModal && EmailSender.canSendMail() ? emailModal : nil)

  }
  
  var emailModal: Modal? {
    let emailSender = EmailSender(subject: "Hi Paul, I saw your resume...",
                                  messageBody: nil,
                                  toRecipients: [contactInfo.value])
    return Modal(emailSender,
                 onDismiss: {
                  self.showEmailModal.toggle()
    })
  }
  
  var safariModal: Modal? {
    if let url = contactInfo.url  {
      return Modal(SafariContainerView(url: url))
    }
    return nil
  }
}

#if DEBUG
struct ContactMethodCell_Previews : PreviewProvider {
  static var previews: some View {
    let resume = Resume()
    return
      NavigationView {
        Form{
          Section {
            ContactMethodCell(contactInfo: resume.contact[1] )
            ContactMethodCell(contactInfo: resume.contact[0] )
          }
        }
    }
  }
}
#endif

