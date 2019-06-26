//
//  Commands.swift
//  StartupCommander
//
//  Created by Paul Wood on 6/24/19.
//  Copyright © 2019 Paul Wood. All rights reserved.
//

import Foundation
import SwiftUI

struct CommandKeys: Hashable, Codable, Identifiable {
    
    var id: String {
        return title
    }
    
    let images: [DisplayImage]
    let title: String
    let subtitle: String
    let keys: [String]
    let body: String
    
    let urlString: String? = nil
    
    var allKeys: String {
       keys.joined(separator: ", ")
    }
}

struct DisplayImage: Hashable, Codable, Identifiable {
    let systemName: String
    var id: String {
        return systemName
    }
}

struct Commander {
    
    static let forAll = "For all commands hold them until you see the screen change from black to "
    
    static let appleSupportRootUrlString = "https://support.apple.com/en-us/HT201255"
    
    static let appleSupportRootUrl: URL = {
        return URL(string: Commander.appleSupportRootUrlString)!
    }()
    
    static let commands = [
        
        CommandKeys(images: [DisplayImage(systemName: "t.square")],
                    title: "Target Disk Mode",
                    subtitle: "",
                    keys: ["T"],
                    body: "A Control Key on Mac OS"),
        
        CommandKeys(images: [DisplayImage(systemName: "d.square")],
                    title: "Force the internal hard drive to be the boot drive",
                    subtitle: "",
                    keys: ["D"],
                    body: ""),
        
        CommandKeys(images: [DisplayImage(systemName: "command"),
                             DisplayImage(systemName: "option"),
                             DisplayImage(systemName: "p.square"),
                             DisplayImage(systemName: "r.square")],
                    title: "Zap the P Ram",
                    subtitle: "",
                    keys: ["Command", "Option", "P", "R"],
                    body: ""),
        
        CommandKeys(images: [DisplayImage(systemName: "command"),
                             DisplayImage(systemName: "option"),
                             DisplayImage(systemName: "n.square"),
                             DisplayImage(systemName: "v.square")],
                    title: " Clear NV RAM.",
                    subtitle: "Similar to reset-all in open Firmware",
                    keys: ["Command", "Option", "N", "V"],
                    body: ""),
        
        CommandKeys(images: [DisplayImage(systemName: "n.square")],
                    title: "Attempt to boot from network server",
                    subtitle: "",
                    keys: ["N"],
                    body: ""),
        
        CommandKeys(images: [DisplayImage(systemName: "command"),
                             DisplayImage(systemName: "option")],
                    title: "Rebuild Desktop",
                    subtitle: "",
                    keys: ["Command", "Option"],
                    body: ""),
        
        CommandKeys(images: [DisplayImage(systemName: "command"),
                             DisplayImage(systemName: "option"),
                             DisplayImage(systemName: "shift"),
                             DisplayImage(systemName: "delete.right")],
                    title: "Bypass startup drive and boot from external",
                    subtitle: "",
                    keys: ["Command", "Option", "Shift", "Delete"],
                    body: ""),
        
        CommandKeys(images: [DisplayImage(systemName: "c.square")],
                    title: "Startup From a CD or DVD",
                    subtitle: "",
                    keys: ["C"],
                    body: "Use this command to startup the mac targeting an onboard CD or DVD Drive or using an external Apple CD Drive Bay (Get proper name before release."),
 
        CommandKeys(images: [DisplayImage(systemName: "command")],
                    title: "Boot with Virtual Memory off",
                    subtitle: "",
                    keys: ["Command"],
                    body: ""),
        
        CommandKeys(images: [DisplayImage(systemName: "shift")],
                    title: "Disable Extensions",
                    subtitle: "",
                    keys: ["Shift"],
                    body: ""),
        
        
        CommandKeys(images: [DisplayImage(systemName: "x.square")],
                    title: "Startup in OSX",
                    subtitle: "",
                    keys: ["X"],
                    body: "If more than one disk is present on Older Macs the X is used to startup in Mac OSX"),
     
        
        /*
         Boot from a specific SCSI ID #. (# is SCSI ID number): command option shift delete #
         Boot into open Firmware: command option O F
         
         Close finder windows (hold just before finder starts): option
         Boot with Virtual Memory off: command
         Trigger extension manager at boot-up: SPACE
         Force Quadra av machines to use TV as a monitor: commandoptionTV
         Boot from ROM (Mac Classic only): commandoptionXO
         Force PowerBooks to reset the screen: R
         Force an AV monitor to be recognized as one: commandoptionAV
         Eject Boot Floppy: Hold Down Mouse Button
         Select volume to start from: option
         Start in Firewire target drive mode: T
         Startup in OSX if OS9 and OXS in boot partition: X or commandX
         Hold down until the 2nd chime, will boot into 9?: commandoption
         OSX: Watch the status of the system load: commandV
         OSX: Enter single-user mode (shell-level mode): command
         */
        
        

    ]
}