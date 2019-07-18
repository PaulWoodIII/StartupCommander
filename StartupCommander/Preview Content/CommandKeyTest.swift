//
//  CommandKeyTest.swift
//  StartupCommander
//
//  Created by Paul Wood on 7/10/19.
//  Copyright © 2019 Paul Wood. All rights reserved.
//

import Foundation

#if DEBUG


struct CommandKeyDebug {
  
  static let commands: [CommandKeys] = [
    CommandKeys(title: "Target Disk Mode",
                body: "A Control Key on Mac OS",
                images: [DisplayImage(systemName: "t.square")],
                keys: ["T"]),
    CommandKeys(title: "Force the internal hard drive to be the boot drive",
                body: "",
                images: [DisplayImage(systemName: "d.square")],
                keys: ["D"]),
    CommandKeys(
                title: "Zap the P Ram",
                body: "",
                images: [DisplayImage(systemName: "command"),
                         DisplayImage(systemName: "option"),
                         DisplayImage(systemName: "p.square"),
                         DisplayImage(systemName: "r.square")],
                keys: ["Command", "Option", "P", "R"]),
    CommandKeys(title: " Clear NV RAM.",
                body: "",
                images: [DisplayImage(systemName: "command"),
                         DisplayImage(systemName: "option"),
                         DisplayImage(systemName: "n.square"),
                         DisplayImage(systemName: "v.square")],
                keys: ["Command", "Option", "N", "V"]),
    CommandKeys(title: "Attempt to boot from network server",
                body: "",
                images: [DisplayImage(systemName: "n.square")],
                keys: ["N"]),
    CommandKeys(title: "Rebuild Desktop",
                body: "",
                images: [DisplayImage(systemName: "command"),
                         DisplayImage(systemName: "option")],
                keys: ["Command", "Option"]),
    CommandKeys(
                title: "Bypass startup drive and boot from external",
                body: "",
                images: [DisplayImage(systemName: "command"),
                         DisplayImage(systemName: "option"),
                         DisplayImage(systemName: "shift"),
                         DisplayImage(systemName: "delete.right")],
                keys: ["Command", "Option", "Shift", "Delete"]),
    CommandKeys(title: "Startup From a CD or DVD",
                body: "Use this command to startup the mac targeting an onboard CD or DVD Drive or using an external Apple CD Drive Bay (Get proper name before release.",
                images: [DisplayImage(systemName: "c.square")],
                keys: ["C"]),
    CommandKeys(title: "Boot with Virtual Memory off",
                body: "",
                images: [DisplayImage(systemName: "command")],
                keys: ["Command"]),
    CommandKeys(title: "Disable Extensions",
                body: "",
                images: [DisplayImage(systemName: "shift")],
                keys: ["Shift"]),
    CommandKeys(title: "Startup in OSX",
                body: "If more than one disk is present on Older Macs the X is used to startup in Mac OSX",
                images: [DisplayImage(systemName: "x.square")],
                keys: ["X"])    
    ]
  
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
  
  
}

#endif
