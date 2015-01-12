//
//  AppleRemote.m
//  AppleRemote
//
//  Created by Guilherme Rambo on 12/01/15.
//  Copyright (c) 2015 Guilherme Rambo. All rights reserved.
//

#import <AppleRemote/AppleRemote.h>

#import <mach/mach.h>
#import <mach/mach_error.h>
#import <IOKit/IOKitLib.h>
#import <IOKit/IOCFPlugIn.h>
#import <IOKit/hid/IOHIDKeys.h>

const char *kAppleRemoteDeviceName = "AppleIRController";

@interface AppleRemoteInternal : HIDRemoteControlDevice
@end

@interface AppleRemoteInternalDelegate : NSObject

@property (assign) AppleRemote *remote;

@end

@interface AppleRemote ()

@property (strong) AppleRemoteInternal *internal;

@end

@implementation AppleRemote

- (instancetype)initWithInternalRemoteDelegate:(id)delegate
{
    self = [super init];
    
    self.internal = [[AppleRemoteInternal alloc] initWithDelegate:delegate];
    
    return self;
}

+ (AppleRemote *)remoteWithListeningMode:(AppleRemoteListeningMode)mode
{
    AppleRemote *_instance;
    AppleRemoteInternalDelegate *_delegate;

    _delegate = [[AppleRemoteInternalDelegate alloc] init];
    _instance = [[AppleRemote alloc] initWithInternalRemoteDelegate:_delegate];
    _delegate.remote = _instance;
    _instance.listeningMode = mode;
    
    return _instance;
}

- (void)setListeningMode:(AppleRemoteListeningMode)listeningMode
{
    _listeningMode = listeningMode;
    
    if (_listeningMode == AppleRemoteListenWhenActiveApp) {
        [[NSNotificationCenter defaultCenter] addObserverForName:NSApplicationDidBecomeActiveNotification object:NSApp queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
            [_internal startListening:nil];
        }];
        [[NSNotificationCenter defaultCenter] addObserverForName:NSApplicationDidResignActiveNotification object:NSApp queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
            [_internal stopListening:nil];
        }];
    } else {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:NSApplicationDidBecomeActiveNotification object:NSApp];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:NSApplicationDidResignActiveNotification object:NSApp];
        [_internal startListening:nil];
    }
}

+ (BOOL)isRemoteAvailable
{
    return [HIDRemoteControlDevice isRemoteAvailable];
}

@end

@implementation AppleRemoteInternal

+ (const char *)remoteControlDeviceName
{
    return kAppleRemoteDeviceName;
}

- (void)setCookieMappingInDictionary:(NSMutableDictionary*)_cookieToButtonMapping
{
    NSMutableDictionary *dict = [NSUnarchiver unarchiveObjectWithFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"AppleRemoteMapping" ofType:@"map"]];
    for (NSString *key in dict.allKeys) {
        _cookieToButtonMapping[key] = dict[key];
    }
}

- (void)sendRemoteButtonEvent:(RemoteControlEventIdentifier)event pressedDown:(BOOL)pressedDown
{
    [super sendRemoteButtonEvent:event pressedDown:pressedDown];
}

@end

@implementation AppleRemoteInternalDelegate

- (void)sendRemoteButtonEvent:(RemoteControlEventIdentifier)event pressedDown:(BOOL)pressedDown remoteControl:(RemoteControl *)remoteControl
{
    if (pressedDown) {
        if (self.remote.pressEventReceiver) {
            self.remote.pressEventReceiver(event);
        } else {
            NSLog(@"[AppleRemote] WARNING: an Apple Remote event occurred but the pressEventReceiver is not set.");
        }
    } else {
        if (self.remote.releaseEventReceiver) {
            self.remote.releaseEventReceiver(event);
        }
    }
}

@end