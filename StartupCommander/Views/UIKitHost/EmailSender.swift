//
//  EmailSender.swift
//  StartupCommander
//
//  Created by Paul Wood on 7/8/19.
//  Copyright © 2019 Paul Wood. All rights reserved.
//

import SwiftUI
import MessageUI
import Combine

class MailDelegate: NSObject, MFMailComposeViewControllerDelegate {
  
  let results = PassthroughSubject<MFMailComposeResult, Error>()
  
  func mailComposeController(_ controller: MFMailComposeViewController,
                             didFinishWith result: MFMailComposeResult,
                             error: Error?) {
    if let error = error {
      results.send(result)
      results.send(completion: .failure(error))
    } else {
      results.send(result)
      results.send(completion: .finished)
    }
    controller.dismiss(animated: true, completion: nil)
  }
}

struct EmailSender: UIViewControllerRepresentable {

  typealias UIViewControllerType = MFMailComposeViewController
  
  init( subject: String?,
        messageBody: String?,
        toRecipients: [String]? ){
    self.subject = subject
    self.messageBody = messageBody
    self.toRecipients = toRecipients
  }
  
  let subject: String?
  let messageBody: String?
  let toRecipients: [String]?
  
  private var mailDelegate: MailDelegate = MailDelegate()
  
  var results: AnyPublisher<MFMailComposeResult, Error> {
    return mailDelegate.results.share().eraseToAnyPublisher()
  }
  
  static func canSendMail() -> Bool {
    return MFMailComposeViewController.canSendMail()
  }
  
  func makeUIViewController(context: UIViewControllerRepresentableContext<EmailSender>) -> MFMailComposeViewController {
    let vc = MFMailComposeViewController()
    let delegate = mailDelegate
    vc.mailComposeDelegate = delegate
    if let subject = subject {
      vc.setSubject(subject)
    }
    if let messageBody = messageBody {
      vc.setMessageBody(messageBody, isHTML: false)
    }
    if let toRecipients = toRecipients {
      vc.setToRecipients(toRecipients)
    }
    return vc
  }
  
  func updateUIViewController(_ uiViewController: MFMailComposeViewController,
                              context: UIViewControllerRepresentableContext<EmailSender>) {
    
  }
}
