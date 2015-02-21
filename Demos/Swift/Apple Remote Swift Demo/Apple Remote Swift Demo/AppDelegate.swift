//
//  AppDelegate.swift
//  Apple Remote Swift Demo
//
//  Created by Guilherme Rambo on 21/02/15.
//  Copyright (c) 2015 Guilherme Rambo. All rights reserved.
//

import Cocoa

import AppleRemoteSimulator
import AppleRemote

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    var appleRemoteView: RSAppleRemoteDeviceView {
        return window.contentView as RSAppleRemoteDeviceView
    }
    
    let remote = AppleRemote(listeningMode: .ListenWhenActiveApp)

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        appleRemoteView.remoteUnavailable = AppleRemote.isRemoteAvailable()
        
        remote.pressEventReceiver = {[unowned self] eventId in
            self.appleRemoteView.displayEvent(Int32(eventId.value))
        }
        
        remote.releaseEventReceiver = {[unowned self] eventId in
            self.appleRemoteView.hideEvent(Int32(eventId.value))
        }
    }


}

