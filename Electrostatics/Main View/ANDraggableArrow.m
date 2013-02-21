//
//  ANDraggableArrow.m
//  Electrostatics
//
//  Created by Nichol, Alexander on 2/21/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANDraggableArrow.h"

@implementation ANDraggableArrow

@synthesize initialPoint;
@synthesize direction;

- (BOOL)shouldDestroy {
    if (!fadeStart) return NO;
    NSTimeInterval timeSinceDestruction = [[NSDate date] timeIntervalSinceDate:fadeStart];
    if (timeSinceDestruction >= 1) return YES;
    return NO;
}

- (void)drawInContext:(CGContextRef)context {
    CGFloat opacity = 1;
    if (fadeStart) {
        NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:fadeStart];
        if (interval > 1) interval = 0;
        opacity = 1 - interval;
    }
    // orthogonal vector
    
    ANVector2D directionWithExtraLength = ANVector2DScale(direction, 1/ANVector2DMagnitude(direction));
    directionWithExtraLength = ANVector2DScale(direction, ANVector2DMagnitude(direction) + 5);
    
    ANVector2D arrowDirection = ANVector2DMake(-direction.y, direction.x);
    arrowDirection = ANVector2DScale(arrowDirection, 5/ANVector2DMagnitude(direction));
    CGContextSetRGBFillColor(context, 0, 0, 0, 1);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, initialPoint.x, initialPoint.y);
    CGContextAddLineToPoint(context, initialPoint.x + direction.x,
                            initialPoint.y + direction.y);
    CGContextAddLineToPoint(context, initialPoint.x + direction.x + arrowDirection.x,
                            initialPoint.y + direction.y + arrowDirection.y);
    CGContextFillPath(context);
}

- (void)beginOutfade {
    
}

@end
