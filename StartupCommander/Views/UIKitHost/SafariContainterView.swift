//
//  SafariContainterView.swift
//  StartupCommander
//
//  Created by Paul Wood on 6/25/19.
//  Copyright © 2019 Paul Wood. All rights reserved.
//

import SwiftUI
import SafariServices
import UIKit

class SafariViewControllerContainerDelegate: NSObject, SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

struct SafariContainerView: UIViewControllerRepresentable {

    typealias UIViewControllerType = SFSafariViewController

    let url: URL
    
    let delegate = SafariViewControllerContainerDelegate()
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariContainerView>) -> SFSafariViewController {
        let vc = SFSafariViewController(url: url)
        vc.delegate = delegate
        return vc
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController,
                                context: UIViewControllerRepresentableContext<SafariContainerView>) {
        
    }
}
