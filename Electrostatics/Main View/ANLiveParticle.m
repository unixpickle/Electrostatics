//
//  ANParticleView.m
//  Electrostatics
//
//  Created by Alex Nichol on 2/18/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANLiveParticle.h"

@implementation ANLiveParticle

@synthesize activeState;
@synthesize isActive;
@synthesize baseParticle;
@synthesize isHighlighted;

- (id)initWithParticle:(ANParticle *)particle {
    if ((self = [super init])) {
        baseParticle = particle;
        [self resignActivityAndReset];
    }
    return self;
}

- (void)beginActivity {
    isHighlighted = NO;
    isActive = YES;
    activeState.activePosition = CGPointMake(baseParticle.positionX, baseParticle.positionY);
    activeState.activeVelocity = ANVector2DMake(baseParticle.velocityX, baseParticle.velocityY);
}

- (void)resignActivityAndReset {
    isActive = NO;
    activeState.activePosition = CGPointMake(baseParticle.positionX, baseParticle.positionY);
    activeState.activeVelocity = ANVector2DMake(baseParticle.velocityX, baseParticle.velocityY);
}

- (ANVector2D)forceOnParticle:(ANLiveParticle *)particle {
    CGPoint selfPosition = self.position;
    CGPoint particlePosition = particle.position;
    ANVector2D direction = ANVector2DMake(selfPosition.x - particlePosition.x, selfPosition.y - particlePosition.y);
    direction = ANVector2DScale(direction, 1/ANVector2DMagnitude(direction));
    CGFloat distance = sqrtf(pow(selfPosition.x - particlePosition.x, 2) + pow(selfPosition.y - particlePosition.y, 2));
    return ANVector2DScale(direction, self.baseParticle.constant * particle.baseParticle.constant / pow(distance, 2));
}

- (CGPoint)position {
    CGPoint position;
    if (isActive) {
        position = activeState.activePosition;
    } else {
        position = CGPointMake(baseParticle.positionX, baseParticle.positionY);
    }
    return position;
}

- (void)drawRect:(CGRect)rect context:(CGContextRef)context {
    CGPoint position = [self position];
    CGRect frame = CGRectMake(position.x - 8, position.y - 8, 16, 16);
    if (isActive) {
        CGContextSetRGBFillColor(context, 1, 0, 0, 1);
    } else {
        if (isHighlighted) {
            CGContextSetRGBFillColor(context, 0.1, 0.3, 1, 1);
        } else {
            CGContextSetRGBFillColor(context, 0, 0, 0, 1);
        }
    }
    CGContextFillEllipseInRect(context, frame);
}

@end
