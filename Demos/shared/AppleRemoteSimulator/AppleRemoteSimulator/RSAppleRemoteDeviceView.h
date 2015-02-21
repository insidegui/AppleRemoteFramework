//
//  RSAppleRemoteDeviceView
//
//  Created by Guilherme Rambo on 21/02/15.
//  Copyright (c) 2015 Guilherme Rambo. All rights reserved.
//

@import Cocoa;

@interface RSAppleRemoteDeviceView : NSView

- (void)displayEvent:(int)event;
- (void)hideEvent:(int)event;

@property (nonatomic, assign, getter=isRemoteUnavailable) BOOL remoteUnavailable;

@end
