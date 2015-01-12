//
//  GRAppleRemoteView.m
//  Apple Remote Demo
//
//  Created by Guilherme Rambo on 12/01/15.
//  Copyright (c) 2015 Guilherme Rambo. All rights reserved.
//

#import "GRAppleRemoteView.h"

@implementation GRAppleRemoteView
{
    NSMutableArray *_events;
}

- (void)setRemoteUnavailable:(BOOL)remoteUnavailable
{
    _remoteUnavailable = remoteUnavailable;
    
    [self setNeedsDisplay:YES];
}

- (void)displayEvent:(RemoteControlEventIdentifier)event
{
    if (!_events) _events = [NSMutableArray new];
    
    NSNumber *theEvent = @(event);
    if ([_events containsObject:theEvent]) return;
    
    [_events addObject:theEvent];
    
    if (event == kRemoteButtonPlay ||
        event == kRemoteButtonPlay_Hold ||
        event == kRemoteButtonMenu ||
        event == kRemoteButtonMenu_Hold ||
        event == kRemoteButtonEnter ||
        event == kRemoteButtonEnter_Hold) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self hideEvent:event];
        });
    }
    
    [self setNeedsDisplay:YES];
}

- (void)hideEvent:(RemoteControlEventIdentifier)event
{
    NSNumber *theEvent = @(event);
    if (![_events containsObject:theEvent]) return;
    
    [_events removeObject:theEvent];
    
    [self setNeedsDisplay:YES];
}

- (CGPoint)volumeUpPoint
{
    return CGPointMake(57, 582);
}

- (CGPoint)volumeDownPoint
{
    return CGPointMake(57, 468);
}

- (CGPoint)backwardPoint
{
    return CGPointMake(1, 525);
}

- (CGPoint)forwardPoint
{
    return CGPointMake(114, 525);
}

- (CGPoint)enterPoint
{
    return CGPointMake(58, 522);
}

- (CGPoint)menuPoint
{
    return CGPointMake(12, 393);
}

- (CGPoint)playPoint
{
    return CGPointMake(102, 393);
}

- (void)drawPressedIndicatorAtPoint:(NSPoint)point
{
    if ((point.x == [self menuPoint].x && point.y == [self menuPoint].y) ||
        (point.x == [self playPoint].x && point.y == [self playPoint].y)) {
        [[NSGraphicsContext currentContext] setCompositingOperation:NSCompositePlusLighter];
    }
    
    CGFloat pressedIndicatorSize = 60.0;
    CGFloat pressedIndicatorRadius = pressedIndicatorSize/2;
    
    //// Color Declarations
    NSColor* pressedGradientColor = [NSColor colorWithCalibratedRed: 0 green: 0.449 blue: 1 alpha: 0.9];
    NSColor* pressedGradientColor2 = [NSColor colorWithCalibratedRed: 0 green: 0.539 blue: 1 alpha: 0];
    
    //// Gradient Declarations
    NSGradient* pressedGradient = [[NSGradient alloc] initWithStartingColor: pressedGradientColor endingColor: pressedGradientColor2];
    
    //// pressedShape Drawing
    NSBezierPath* pressedShapePath = [NSBezierPath bezierPathWithOvalInRect: NSMakeRect(point.x, point.y, pressedIndicatorSize, pressedIndicatorSize)];
    [NSGraphicsContext saveGraphicsState];
    [pressedShapePath addClip];
    [pressedGradient drawFromCenter: NSMakePoint(pressedIndicatorRadius+point.x, pressedIndicatorRadius+point.y) radius: 5
                           toCenter: NSMakePoint(pressedIndicatorRadius+point.x, pressedIndicatorRadius+point.y) radius: 27
                            options: NSGradientDrawsBeforeStartingLocation | NSGradientDrawsAfterEndingLocation];
    [NSGraphicsContext restoreGraphicsState];
}

- (void)drawRect:(NSRect)dirtyRect {
    //// Color Declarations
    NSColor* bezelColor1 = [NSColor colorWithCalibratedRed: 0.811 green: 0.816 blue: 0.826 alpha: 1];
    NSColor* bezelColor2 = [NSColor colorWithCalibratedRed: 0.864 green: 0.868 blue: 0.878 alpha: 1];
    NSColor* bezelColor3 = [NSColor colorWithCalibratedRed: 0.479 green: 0.483 blue: 0.501 alpha: 1];
    NSColor* bezelColor4 = [NSColor colorWithCalibratedRed: 0.687 green: 0.691 blue: 0.71 alpha: 1];
    NSColor* bezelColor5 = [NSColor colorWithCalibratedRed: 0.854 green: 0.859 blue: 0.869 alpha: 1];
    NSColor* buttonColor1 = [NSColor colorWithCalibratedRed: 0.109 green: 0.111 blue: 0.121 alpha: 1];
    NSColor* buttonColor2 = [NSColor colorWithCalibratedRed: 0.022 green: 0.022 blue: 0.023 alpha: 1];
    NSColor* enterButtonGradientColor = [NSColor colorWithCalibratedRed: 0.534 green: 0.537 blue: 0.556 alpha: 1];
    NSColor* enterButtonGradientColor2 = [NSColor colorWithCalibratedRed: 0.84 green: 0.844 blue: 0.854 alpha: 1];
    
    //// Gradient Declarations
    NSGradient* bezelGradient = [[NSGradient alloc] initWithColorsAndLocations:
                                 bezelColor1, 0.0,
                                 [NSColor colorWithCalibratedRed: 0.833 green: 0.837 blue: 0.847 alpha: 1], 0.05,
                                 bezelColor5, 0.19,
                                 bezelColor2, 0.37,
                                 [NSColor colorWithCalibratedRed: 0.775 green: 0.779 blue: 0.794 alpha: 1], 0.60,
                                 bezelColor4, 0.73,
                                 bezelColor3, 1.0, nil];
    NSGradient* buttonGradient = [[NSGradient alloc] initWithStartingColor: buttonColor1 endingColor: buttonColor2];
    NSGradient* enterButtonGradient = [[NSGradient alloc] initWithStartingColor: enterButtonGradientColor endingColor: enterButtonGradientColor2];
    
    //// Shadow Declarations
    NSShadow* enterButtonInnerShadow = [[NSShadow alloc] init];
    [enterButtonInnerShadow setShadowColor: [[NSColor blackColor] colorWithAlphaComponent: 0.3]];
    [enterButtonInnerShadow setShadowOffset: NSMakeSize(3.1, 1.1)];
    [enterButtonInnerShadow setShadowBlurRadius: 9];
    
    //// Abstracted Attributes
    NSString* menuButtonTextContent = @"MENU";
    
    
    //// appleRemoteBezel Drawing
    NSBezierPath* appleRemoteBezelPath = [NSBezierPath bezierPathWithRoundedRect: NSMakeRect(1, -1, 174, 701) xRadius: 23 yRadius: 23];
    [bezelGradient drawInBezierPath: appleRemoteBezelPath angle: 0];
    
    
    //// directionals Drawing
    NSBezierPath* directionalsPath = [NSBezierPath bezierPathWithOvalInRect: NSMakeRect(10, 477, 155, 155)];
    [buttonGradient drawInBezierPath: directionalsPath angle: 0];
    
    
    //// enterButton Drawing
    NSBezierPath* enterButtonPath = [NSBezierPath bezierPathWithOvalInRect: NSMakeRect(51, 517, 73, 73)];
    [enterButtonGradient drawInBezierPath: enterButtonPath angle: -90];
    
    ////// enterButton Inner Shadow
    NSRect enterButtonBorderRect = NSInsetRect([enterButtonPath bounds], -enterButtonInnerShadow.shadowBlurRadius, -enterButtonInnerShadow.shadowBlurRadius);
    enterButtonBorderRect = NSOffsetRect(enterButtonBorderRect, -enterButtonInnerShadow.shadowOffset.width, -enterButtonInnerShadow.shadowOffset.height);
    enterButtonBorderRect = NSInsetRect(NSUnionRect(enterButtonBorderRect, [enterButtonPath bounds]), -1, -1);
    
    NSBezierPath* enterButtonNegativePath = [NSBezierPath bezierPathWithRect: enterButtonBorderRect];
    [enterButtonNegativePath appendBezierPath: enterButtonPath];
    [enterButtonNegativePath setWindingRule: NSEvenOddWindingRule];
    
    [NSGraphicsContext saveGraphicsState];
    {
        NSShadow* enterButtonInnerShadowWithOffset = [enterButtonInnerShadow copy];
        CGFloat xOffset = enterButtonInnerShadowWithOffset.shadowOffset.width + round(enterButtonBorderRect.size.width);
        CGFloat yOffset = enterButtonInnerShadowWithOffset.shadowOffset.height;
        enterButtonInnerShadowWithOffset.shadowOffset = NSMakeSize(xOffset + copysign(0.1, xOffset), yOffset + copysign(0.1, yOffset));
        [enterButtonInnerShadowWithOffset set];
        [[NSColor grayColor] setFill];
        [enterButtonPath addClip];
        NSAffineTransform* transform = [NSAffineTransform transform];
        [transform translateXBy: -round(enterButtonBorderRect.size.width) yBy: 0];
        [[transform transformBezierPath: enterButtonNegativePath] fill];
    }
    [NSGraphicsContext restoreGraphicsState];
    
    
    
    //// menuButton Drawing
    NSBezierPath* menuButtonPath = [NSBezierPath bezierPathWithOvalInRect: NSMakeRect(9.5, 390.5, 67, 67)];
    [buttonGradient drawInBezierPath: menuButtonPath angle: -90];
    
    
    //// playButton Drawing
    NSBezierPath* playButtonPath = [NSBezierPath bezierPathWithOvalInRect: NSMakeRect(99, 391, 67, 67)];
    [buttonGradient drawInBezierPath: playButtonPath angle: -90];
    
    
    //// menuButtonText Drawing
    NSRect menuButtonTextRect = NSMakeRect(23, 413, 40, 17);
    NSMutableParagraphStyle* menuButtonTextStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    [menuButtonTextStyle setAlignment: NSCenterTextAlignment];
    
    NSDictionary* menuButtonTextFontAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                                  [NSFont boldSystemFontOfSize: 10.5], NSFontAttributeName,
                                                  bezelColor2, NSForegroundColorAttributeName,
                                                  menuButtonTextStyle, NSParagraphStyleAttributeName, nil];
    
    [menuButtonTextContent drawInRect: NSOffsetRect(menuButtonTextRect, 0, 0) withAttributes: menuButtonTextFontAttributes];
    
    
    //// playGlyph Drawing
    NSBezierPath* playGlyphPath = [NSBezierPath bezierPath];
    [playGlyphPath moveToPoint: NSMakePoint(123.5, 429.5)];
    [playGlyphPath lineToPoint: NSMakePoint(133.5, 424.5)];
    [playGlyphPath lineToPoint: NSMakePoint(123.5, 419.5)];
    [playGlyphPath lineToPoint: NSMakePoint(123.5, 429.5)];
    [playGlyphPath closePath];
    [bezelColor2 setFill];
    [playGlyphPath fill];
    
    
    //// pauseGlyph1 Drawing
    NSBezierPath* pauseGlyph1Path = [NSBezierPath bezierPathWithRect: NSMakeRect(136, 420, 2, 9)];
    [bezelColor2 setFill];
    [pauseGlyph1Path fill];
    
    
    //// pauseGlyph2 Drawing
    NSBezierPath* pauseGlyph2Path = [NSBezierPath bezierPathWithRect: NSMakeRect(140, 420, 2, 9)];
    [bezelColor2 setFill];
    [pauseGlyph2Path fill];
    
    if (self.isRemoteUnavailable) {
        return [self drawUnavailableOverlay];
    }
    
    for (NSNumber *event in _events) {
        if (event.intValue == kRemoteButtonPlus || event.intValue == kRemoteButtonPlus_Hold) [self drawPressedIndicatorAtPoint:[self volumeUpPoint]];
        if (event.intValue == kRemoteButtonMinus || event.intValue == kRemoteButtonMinus_Hold) [self drawPressedIndicatorAtPoint:[self volumeDownPoint]];
        if (event.intValue == kRemoteButtonLeft_Hold) [self drawPressedIndicatorAtPoint:[self backwardPoint]];
        if (event.intValue == kRemoteButtonRight_Hold) [self drawPressedIndicatorAtPoint:[self forwardPoint]];
        if (event.intValue == kRemoteButtonEnter) [self drawPressedIndicatorAtPoint:[self enterPoint]];
        if (event.intValue == kRemoteButtonMenu) [self drawPressedIndicatorAtPoint:[self menuPoint]];
        if (event.intValue == kRemoteButtonPlay) [self drawPressedIndicatorAtPoint:[self playPoint]];
    }
}

- (void)drawUnavailableOverlay
{
    //// Color Declarations
    NSColor* unavailableOverlayColor = [NSColor colorWithCalibratedRed: 1 green: 1 blue: 1 alpha: 0.733];
    NSColor* unavailableTextColor = [NSColor colorWithCalibratedRed: 0.886 green: 0 blue: 0 alpha: 1];
    
    //// Abstracted Attributes
    NSString* unavailableTextContent = @"Infrared is not available";
    
    
    //// unavailableOverlay Drawing
    NSBezierPath* unavailableOverlayPath = [NSBezierPath bezierPathWithRoundedRect: NSMakeRect(1, -1, 174, 701) xRadius: 23 yRadius: 23];
    [unavailableOverlayColor setFill];
    [unavailableOverlayPath fill];
    
    
    //// unavailableText Drawing
    NSRect unavailableTextRect = NSMakeRect(18, 656, 140, 17);
    NSMutableParagraphStyle* unavailableTextStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    [unavailableTextStyle setAlignment: NSCenterTextAlignment];
    
    NSDictionary* unavailableTextFontAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                                   [NSFont boldSystemFontOfSize: [NSFont smallSystemFontSize]], NSFontAttributeName,
                                                   unavailableTextColor, NSForegroundColorAttributeName,
                                                   unavailableTextStyle, NSParagraphStyleAttributeName, nil];
    
    [unavailableTextContent drawInRect: NSOffsetRect(unavailableTextRect, 0, 0) withAttributes: unavailableTextFontAttributes];
}

@end
