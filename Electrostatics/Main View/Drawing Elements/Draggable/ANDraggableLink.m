//
//  ANDraggableLink.m
//  Electrostatics
//
//  Created by Alex Nichol on 4/16/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANDraggableLink.h"

@implementation ANDraggableLink

@synthesize initialPoint;
@synthesize endPoint;

- (id)initWithPoint:(CGPoint)theInitPoint {
    if ((self = [super init])) {
        initialPoint = theInitPoint;
        endPoint = theInitPoint;
    }
    return self;
}

- (BOOL)shouldDestroy {
    if (!fadeStart) return NO;
    NSTimeInterval timeSinceDestruction = [[NSDate date] timeIntervalSinceDate:fadeStart];
    if (timeSinceDestruction >= kANDraggableLinkFadeTime) return YES;
    return NO;
}

- (void)drawInContext:(CGContextRef)context {
    CGFloat opacity = 1;
    if (fadeStart) {
        NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:fadeStart];
        if (interval > kANDraggableLinkFadeTime) return;
        opacity = 1 - interval / kANDraggableLinkFadeTime;
    }
    CGContextSetAlpha(context, opacity);
}

- (void)beginOutfade {
    fadeStart = [NSDate date];
}

@end
