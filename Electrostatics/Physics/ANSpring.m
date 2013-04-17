//
//  ANSpring.m
//  Electrostatics
//
//  Created by Alex Nichol on 4/16/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANSpring.h"

@implementation ANSpring

@synthesize p1;
@synthesize p2;
@synthesize restLength;
@synthesize coefficient;

- (id)initWithParticle:(ANParticle *)theP1 toParticle:(ANParticle *)theP2 {
    if ((self = [super init])) {
        p1 = theP1;
        p2 = theP2;
        restLength = [theP1 distanceToParticle:theP2];
        coefficient = 30;
    }
    return self;
}

- (ANVector2D)forceOnP1 {
    ANVector2D dirVec = ANVector2DMake(p2.positionX - p1.positionX, p2.positionY - p1.positionY);
    CGFloat distance = ANVector2DMagnitude(dirVec);
    CGFloat force = (distance - restLength) * coefficient;
    return ANVector2DScale(dirVec, force/distance);
}

- (ANVector2D)forceOnP2 {
    ANVector2D dirVec = ANVector2DMake(p1.positionX - p2.positionX, p1.positionY - p2.positionY);
    CGFloat distance = ANVector2DMagnitude(dirVec);
    CGFloat force = (distance - restLength) * coefficient;
    return ANVector2DScale(dirVec, force/distance);
}

@end
