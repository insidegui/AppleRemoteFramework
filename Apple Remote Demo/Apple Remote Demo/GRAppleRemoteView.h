//
//  GRAppleRemoteView.h
//  Apple Remote Demo
//
//  Created by Guilherme Rambo on 12/01/15.
//  Copyright (c) 2015 Guilherme Rambo. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@import AppleRemote;

@interface GRAppleRemoteView : NSView

- (void)displayEvent:(RemoteControlEventIdentifier)event;
- (void)hideEvent:(RemoteControlEventIdentifier)event;

@property (nonatomic, assign, getter=isRemoteUnavailable) BOOL remoteUnavailable;

@end
