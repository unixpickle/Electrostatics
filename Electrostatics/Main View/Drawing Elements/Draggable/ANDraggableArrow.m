//
//  ANDraggableArrow.m
//  Electrostatics
//
//  Created by Nichol, Alexander on 2/21/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANDraggableArrow.h"

@implementation ANDraggableArrow

- (ANVector2D)direction {
    return ANVector2DMake(endPoint.x - initialPoint.x, endPoint.y - initialPoint.y);
}

- (void)drawInContext:(CGContextRef)context {
    [super drawInContext:context];
    
    ANVector2D directionWithExtraLength = ANVector2DScale(direction, 1/ANVector2DMagnitude(direction));
    directionWithExtraLength = ANVector2DScale(directionWithExtraLength, ANVector2DMagnitude(direction) + kANDraggableArrowTipSize);
    
    ANVector2D arrowDirection = ANVector2DMake(-direction.y, direction.x);
    arrowDirection = ANVector2DScale(arrowDirection, kANDraggableArrowTipSize/ANVector2DMagnitude(direction));
    CGContextSetRGBStrokeColor(context, 0, 0, 0, 1);
    CGContextSetRGBFillColor(context, 0, 0, 0, 1);
    CGContextSetLineWidth(context, 2);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, initialPoint.x, initialPoint.y);
    CGContextAddLineToPoint(context, initialPoint.x + direction.x,
                            initialPoint.y + direction.y);
    CGContextStrokePath(context);
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, initialPoint.x + directionWithExtraLength.x,
                         initialPoint.y + directionWithExtraLength.y);
    CGContextAddLineToPoint(context, initialPoint.x + direction.x + arrowDirection.x,
                            initialPoint.y + direction.y + arrowDirection.y);
    CGContextAddLineToPoint(context, initialPoint.x + direction.x - arrowDirection.x,
                            initialPoint.y + direction.y - arrowDirection.y);
    CGContextClosePath(context);
    CGContextFillPath(context);
    
    // restore alpha from [super drawInContext:]
    CGContextSetAlpha(context, 1);
}

@end
