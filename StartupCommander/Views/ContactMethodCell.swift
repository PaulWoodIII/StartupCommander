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
  
  var sheetSelection: State<SheetOptions?> = State(initialValue: nil)
  
  enum SheetOptions: Identifiable, Hashable {
    var id: Int {
      return self.hashValue
    }
    case email(_: EmailSender.Config)
    case url(_: URL)
    
    var view: some View {
      switch self {
      case .email(let config):
        return NavigationView {
          EmailSender(config: config)
        }.typeErased
      case .url(let url):
        return SafariContainerView(url: url).typeErased
      }
    }
  }
  
  func contactAction() {
    if contactInfo.urlString.hasPrefix("http"), let url = contactInfo.url {
      self.sheetSelection.value = .url(url)
    } else if contactInfo.urlString.hasPrefix("telprompt:") {
      let phoneNumber =
        String(contactInfo.urlString.dropFirst("telprompt:".count))
      phoneCaller.call(phoneNumber)
    } else if contactInfo.urlString.hasPrefix("mailto:") {
      self.sheetSelection.value = .email(EmailSender.Config(
        subject: "Hi Paul, I saw your resume...",
        messageBody: nil,
        toRecipients: [contactInfo.urlString]
        )
      )
    }
  }
  
  var body: some View {
    HStack {
      Text(contactInfo.type + ": ")
      Button(action: contactAction,
             label: {Text(contactInfo.value)})
    }.sheet(item: sheetSelection.binding,
            onDismiss: { self.sheetSelection.value = nil },
            content: { sheetSelection in
                          return sheetSelection.view
    })
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

