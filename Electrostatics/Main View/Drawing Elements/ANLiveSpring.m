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
    
}

@end
