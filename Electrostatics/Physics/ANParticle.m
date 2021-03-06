//
//  ANParticle.m
//  Electrostatics
//
//  Created by Alex Nichol on 2/15/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANParticle.h"

@implementation ANParticle

@synthesize positionX, positionY;
@synthesize velocityX, velocityY;
@synthesize constant;
@synthesize color;
@synthesize fixedVelocity;

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super init])) {
        positionX = [aDecoder decodeDoubleForKey:@"positionX"];
        positionY = [aDecoder decodeDoubleForKey:@"positionY"];
        velocityX = [aDecoder decodeDoubleForKey:@"velocityX"];
        velocityY = [aDecoder decodeDoubleForKey:@"velocityY"];
        constant = [aDecoder decodeDoubleForKey:@"constant"];
        color = [aDecoder decodeObjectForKey:@"color"];
        fixedVelocity = [aDecoder decodeBoolForKey:@"fixedVelocity"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeDouble:positionX forKey:@"positionX"];
    [aCoder encodeDouble:positionY forKey:@"positionY"];
    [aCoder encodeDouble:velocityX forKey:@"velocityX"];
    [aCoder encodeDouble:velocityY forKey:@"velocityY"];
    [aCoder encodeDouble:constant forKey:@"constant"];
    [aCoder encodeObject:color forKey:@"color"];
    [aCoder encodeBool:fixedVelocity forKey:@"fixedVelocity"];
}

- (ANVector2D)forceOnParticle:(ANParticle *)particle {
    ANVector2D direction = ANVector2DMake(self.positionX - particle.positionX, self.positionY - particle.positionY);
    direction = ANVector2DScale(direction, 1/ANVector2DMagnitude(direction));
    CGFloat distance = sqrtf(pow(self.positionX - particle.positionX, 2) + pow(self.positionY - particle.positionY, 2));
    return ANVector2DScale(direction, self.constant * particle.constant / pow(distance, 2));
}

- (CGFloat)distanceToParticle:(ANParticle *)anotherParticle {
    ANVector2D offset = ANVector2DMake(anotherParticle.positionX - self.positionX,
                                       anotherParticle.positionY - self.positionY);
    return ANVector2DMagnitude(offset);
}

@end
