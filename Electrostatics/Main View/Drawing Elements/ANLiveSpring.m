//
//  ANLiveSpring.m
//  Electrostatics
//
//  Created by Alex Nichol on 4/16/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANLiveSpring.h"

@implementation ANLiveSpring

@synthesize spring;
@synthesize particle1;
@synthesize particle2;

- (ANVector2D)forceOnParticle:(ANLiveParticle *)particle {
    return ANVector2DMake(0, 0);
}

- (void)drawInContext:(CGContextRef)context {
    CGContextSetRGBStrokeColor(context, 1, 1, 0, 1);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, particle1.position.x, particle1.position.y);
    CGContextAddLineToPoint(context, particle2.position.x, particle2.position.y);
    CGContextStrokePath(context);
}

@end
