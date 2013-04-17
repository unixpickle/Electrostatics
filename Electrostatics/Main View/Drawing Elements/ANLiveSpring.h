//
//  ANLiveSpring.h
//  Electrostatics
//
//  Created by Alex Nichol on 4/16/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANSpring.h"
#import "ANLiveParticle.h"

@interface ANLiveSpring : NSObject {
    ANSpring * spring;
    ANLiveParticle * particle1;
    ANLiveParticle * particle2;
    
    BOOL isHighlighted;
}

@property (nonatomic, retain) ANSpring * spring;
@property (nonatomic, retain) ANLiveParticle * particle1;
@property (nonatomic, retain) ANLiveParticle * particle2;
@property (readwrite) BOOL isHighlighted;

- (ANVector2D)forceOnParticle:(ANLiveParticle *)particle;
- (void)drawInContext:(CGContextRef)context;

- (CGFloat)closestDistanceToPoint:(CGPoint)point;

@end
