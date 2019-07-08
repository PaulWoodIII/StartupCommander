//
//  PhoneCaller.swift
//  StartupCommander
//
//  Created by Paul Wood on 7/8/19.
//  Copyright © 2019 Paul Wood. All rights reserved.
//

import UIKit

struct PhoneCaller {
  func call(_ phone: String) {
    let phoneUrl = URL(string: "telprompt://\(phone)")
    let phoneFallbackUrl = URL(string: "tel://\(phone)")
    if(phoneUrl != nil && UIApplication.shared.canOpenURL(phoneUrl!)) {
      UIApplication.shared.open(phoneUrl!, options:[:]) { (success) in
        if(!success) {
          print("Failed opening the url")
        }
      }
    } else if(phoneFallbackUrl != nil && UIApplication.shared.canOpenURL(phoneFallbackUrl!)) {
      UIApplication.shared.open(phoneFallbackUrl!, options:[:]) { (success) in
        if(!success) {
          print("Failed opening the url 2")
        }
      }
    } else {
      print("Your device can not do phone calls.")
    }
  }
}
