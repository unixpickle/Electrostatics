//
//  ANParticle.h
//  Electrostatics
//
//  Created by Alex Nichol on 2/15/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANVector2D.h"

@interface ANParticle : NSObject <NSCoding> {
    double positionX, positionY;
    double velocityX, velocityY;
    double constant;
    UIColor * color;
    BOOL fixedVelocity;
}

@property (readwrite) double positionX, positionY;
@property (readwrite) double velocityX, velocityY;
@property (readwrite) double constant;
@property (nonatomic, retain) UIColor * color;
@property (readwrite) BOOL fixedVelocity;

- (ANVector2D)forceOnParticle:(ANParticle *)particle;
- (CGFloat)distanceToParticle:(ANParticle *)anotherParticle;

@end
