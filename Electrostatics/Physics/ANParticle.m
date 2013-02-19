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

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super init])) {
        positionX = [aDecoder decodeDoubleForKey:@"positionX"];
        positionY = [aDecoder decodeDoubleForKey:@"positionY"];
        velocityX = [aDecoder decodeDoubleForKey:@"velocityX"];
        velocityY = [aDecoder decodeDoubleForKey:@"velocityY"];
        constant = [aDecoder decodeDoubleForKey:@"constant"];
        color = [aDecoder decodeObjectForKey:@"color"];
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
}

- (ANVector2D)forceOnParticle:(ANParticle *)particle {
    ANVector2D direction = ANVector2DMake(self.positionX - particle.positionX, self.positionY - particle.positionY);
    direction = ANVector2DScale(direction, 1/ANVector2DMagnitude(direction));
    CGFloat distance = sqrtf(pow(self.positionX - particle.positionX, 2) + pow(self.positionY - particle.positionY, 2));
    return ANVector2DScale(direction, self.constant * particle.constant / pow(distance, 2));
}

@end
