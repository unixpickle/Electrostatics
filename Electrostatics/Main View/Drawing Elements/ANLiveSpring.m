//
//  ANLiveSpring.m
//  Electrostatics
//
//  Created by Alex Nichol on 4/16/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANLiveSpring.h"

@interface ANLiveSpring (Private)

- (float)pullIntensity;

@end

@implementation ANLiveSpring

@synthesize spring;
@synthesize particle1;
@synthesize particle2;
@synthesize isHighlighted;

- (ANVector2D)forceOnParticle:(ANLiveParticle *)particle {
    ANVector2D initialVector;
    if (particle == particle1) {
        initialVector = ANVector2DMake(particle2.position.x - particle.position.x,
                                       particle2.position.y - particle.position.y);
    }
    if (particle == particle2) {
        initialVector = ANVector2DMake(particle1.position.x - particle.position.x,
                                       particle1.position.y - particle.position.y);
    }
    CGFloat distance = ANVector2DMagnitude(initialVector);
    CGFloat force = (distance - spring.restLength) * spring.coefficient;
    return ANVector2DScale(initialVector, force / distance);
}

- (void)drawInContext:(CGContextRef)context {
    if (isHighlighted) {
        CGContextSetRGBStrokeColor(context, 0, 0.8, 0, 1);
    } else {
        float intensity = [self pullIntensity];
        if (intensity > 0) {
            CGContextSetRGBStrokeColor(context, intensity, 0, 0, 1);
        } else {
            CGContextSetRGBStrokeColor(context, 0, 0, -intensity, 1);
        }
    }
    
    CGContextSetLineWidth(context, 5);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, particle1.position.x, particle1.position.y);
    CGContextAddLineToPoint(context, particle2.position.x, particle2.position.y);
    CGContextStrokePath(context);
}

- (CGFloat)closestDistanceToPoint:(CGPoint)point {
    // you'd really have to see my notes in order to understand this
    ANVector2D springVec = ANVector2DMake(particle2.position.x - particle1.position.x,
                                          particle2.position.y - particle1.position.y);
    ANVector2D pointVec = ANVector2DMake(point.x - particle1.position.x,
                                         point.y - particle1.position.y);
    
    // calculate the projection vector and do some useful stuff in the process
    CGFloat springScalar = ANVector2DDot(springVec, pointVec) / ANVector2DDot(springVec, springVec);
    if (springScalar > 1) {
        // closest distance is distance to p2
        ANVector2D vecToP2 = ANVector2DMake(point.x - particle2.position.x, point.y - particle2.position.y);
        return ANVector2DMagnitude(vecToP2);
    } else if (springScalar < 0) {
        // closest distance is distance to p1
        ANVector2D vecToP1 = ANVector2DMake(point.x - particle1.position.x, point.y - particle1.position.y);
        return ANVector2DMagnitude(vecToP1);
    } else {
        ANVector2D negProjection = ANVector2DScale(springVec, -springScalar);
        ANVector2D error = ANVector2DAdd(pointVec, negProjection);
        return ANVector2DMagnitude(error);
    }
}

#pragma mark - Private -

- (float)pullIntensity {
    ANVector2D initialVector = ANVector2DMake(particle2.position.x - particle1.position.x,
                                              particle2.position.y - particle1.position.y);
    CGFloat distance = ANVector2DMagnitude(initialVector) - spring.restLength;
    if (distance > 0) {
        return 1 - expf(-distance / 50);
    } else {
        return expf(distance / 50) - 1;
    }
}

@end
