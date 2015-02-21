//
//  AppDelegate.m
//  Apple Remote Demo
//
//  Created by Guilherme Rambo on 12/01/15.
//  Copyright (c) 2015 Guilherme Rambo. All rights reserved.
//

#import "AppDelegate.h"

@import AppleRemote;
@import AppleRemoteSimulator;

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property (strong) AppleRemote *remote;

@property (readonly) RSAppleRemoteDeviceView *appleRemoteView;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // setup an AppleRemote
    self.remote = [AppleRemote remoteWithListeningMode:AppleRemoteListenWhenActiveApp];
    
    __weak typeof(self) weakSelf = self;
    
    // check if remote is available
    self.appleRemoteView.remoteUnavailable = [AppleRemote isRemoteAvailable];
    
    // set the block to be called when a button is pressed
    [self.remote setPressEventReceiver:^(RemoteControlEventIdentifier eventId) {
        [weakSelf.appleRemoteView displayEvent:eventId];
    }];
    
    // set the block to be called when a button is released
    [self.remote setReleaseEventReceiver:^(RemoteControlEventIdentifier eventId) {
        [weakSelf.appleRemoteView hideEvent:eventId];
    }];
}

- (RSAppleRemoteDeviceView *)appleRemoteView
{
    return (RSAppleRemoteDeviceView *)self.window.contentView;
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
