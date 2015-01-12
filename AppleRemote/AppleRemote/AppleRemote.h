//
//  AppleRemote.h
//  AppleRemote
//
//  Created by Guilherme Rambo on 12/01/15.
//  Copyright (c) 2015 Guilherme Rambo. All rights reserved.
//

#import <Cocoa/Cocoa.h>

//! Project version number for AppleRemote.
FOUNDATION_EXPORT double AppleRemoteVersionNumber;

//! Project version string for AppleRemote.
FOUNDATION_EXPORT const unsigned char AppleRemoteVersionString[];

#import "HIDRemoteControlDevice.h"

/*!
 @typedef Remote listening modes
 @constant AppleRemoteListenWhenActiveApp
 @constant AppleRemoteListenAlways
 */
typedef NS_ENUM(int, AppleRemoteListeningMode){
    /// The remote events are captured only if the app is active
    AppleRemoteListenWhenActiveApp,
    
    /// The remote events are captured even when the app is inactive
    AppleRemoteListenAlways
};

@interface AppleRemote : NSObject

/*!
 @brief Returns an AppleRemote instance, if IR is not available, returns nil
 @discussion
 This returns an AppleRemote instance which you can use to listen to Apple Remote events
 * @warning Don't forget to set the pressEventReceiver and releaseEventReceiver blocks
 */
+ (AppleRemote *)remoteWithListeningMode:(AppleRemoteListeningMode)mode;

/*!
 @brief Sets the remote's listening mode
 */
@property (nonatomic, assign) AppleRemoteListeningMode listeningMode;

/*!
 @brief Returns YES if infrared is available
 */
+ (BOOL)isRemoteAvailable;

/*!
 @brief A block to be executed when a remote control button is pressed
 */
@property (nonatomic, copy) void(^pressEventReceiver)(RemoteControlEventIdentifier eventId);

/*!
 @brief A block to be executed when a remote control button is released
 @warning The Play/Pause, Menu and Enter buttons don't have a "released" event
 */
@property (nonatomic, copy) void(^releaseEventReceiver)(RemoteControlEventIdentifier eventId);

@end