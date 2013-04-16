//
//  ANDraggableSpring.m
//  Electrostatics
//
//  Created by Alex Nichol on 4/16/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANDraggableSpring.h"

@implementation ANDraggableSpring

- (void)drawInContext:(CGContextRef)context {
    [super drawInContext:context];
    
    CGContextSetLineWidth(context, 5);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetRGBStrokeColor(context, 1, 1, 0, 1);
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, initialPoint.x, initialPoint.y);
    CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
    CGContextStrokePath(context);
    
    CGContextSetAlpha(context, 1);
}

@end
