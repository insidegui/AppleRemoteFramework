//
//  RSRemoteDeviceSimulatorWindow
//
//  Created by Guilherme Rambo on 21/02/15.
//  Copyright (c) 2015 Guilherme Rambo. All rights reserved.
//

#import "RSRemoteDeviceSimulatorWindow.h"

@implementation RSRemoteDeviceSimulatorWindow

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setMovableByWindowBackground:YES];
    [self center];
}

- (instancetype)initWithContentRect:(NSRect)contentRect styleMask:(NSUInteger)aStyle backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag
{
    if (!(self = [super initWithContentRect:contentRect styleMask:aStyle backing:bufferingType defer:flag])) return nil;
    
    self.opaque = NO;
    self.backgroundColor = [NSColor clearColor];
    self.movableByWindowBackground = YES;
    
    return self;
}

- (void)makeKeyAndOrderFront:(id)sender
{
    [self center];
    [super makeKeyAndOrderFront:sender];
}

- (BOOL)canBecomeKeyWindow
{
    return YES;
}

- (BOOL)canBecomeMainWindow
{
    return YES;
}

@end
