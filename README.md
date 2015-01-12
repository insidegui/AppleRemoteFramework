# Apple Remote Framework

A framework to use the Apple Remote to control your apps.

## Documentation

The functionality is wrapped in a single class: `AppleRemote`. Take a look at the header, it's pretty well documented.

The sample app included shows a really good example of how It can be used, but the basic usage is as shown below:

```objective-c
// setup an AppleRemote
self.remote = [AppleRemote remoteWithListeningMode:AppleRemoteListenWhenActiveApp];
    
// set the block to be called when a button is pressed
[self.remote setPressEventReceiver:^(RemoteControlEventIdentifier eventId) {
   // do something with eventId, probably a switch :)
}];
    
// set the block to be called when a button is released
[self.remote setReleaseEventReceiver:^(RemoteControlEventIdentifier eventId) {
   // do something with eventId
}];
```

![demo app screenshot](https://raw.github.com/insidegui/AppleRemoteFramework/master/screenshot.png)

### Thanks

This framework is based on classes created by **Martin Kahr**, thanks Martin for your great work.

### Contributing

You can contribute with code, just send me a pull request, or open an issue for any bug/enhancement. Please try to code in a similar way to the code that's already been written.

Disclaimer: sending a pull request does not mean I will accept It, if I don't accept your pull request It doesn't mean I don't love you ;)