//
//  ANSaveableScene.m
//  Electrostatics
//
//  Created by Alex Nichol on 4/16/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANSaveableScene.h"

@interface ANSaveableScene (Private)

- (NSDictionary *)dictionaryForSpring:(ANSpring *)spring;
- (ANSpring *)springForParticleInfo:(NSDictionary *)info;

@end

@implementation ANSaveableScene

@synthesize particles;
@synthesize springs;

- (id)initWithParticles:(NSArray *)theParticles springs:(NSArray *)theSprings {
    if ((self = [super init])) {
        particles = theParticles;
        springs = theSprings;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
    if ((self = [super init])) {
        NSArray * springsInfo = [decoder decodeObjectForKey:@"springs"];
        particles = [decoder decodeObjectForKey:@"particles"];
		NSMutableArray * mSprings = [NSMutableArray array];
        for (NSDictionary * info in springsInfo) {
			[mSprings addObject:[self springForParticleInfo:info]];
		}
		springs = [mSprings copy];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    NSMutableArray * springsInfo = [NSMutableArray array];
    for (ANSpring * spring in springs) {
        [springsInfo addObject:[self dictionaryForSpring:spring]];
    }
    [aCoder encodeObject:springsInfo forKey:@"springs"];
    [aCoder encodeObject:particles forKey:@"particles"];
}

#pragma mark - Private -

- (NSDictionary *)dictionaryForSpring:(ANSpring *)spring {
    NSNumber * index1 = [NSNumber numberWithInteger:[particles indexOfObject:spring.p1]];
    NSNumber * index2 = [NSNumber numberWithInteger:[particles indexOfObject:spring.p2]];
    return [NSDictionary dictionaryWithObjectsAndKeys:
            [NSNumber numberWithFloat:spring.restLength], @"restLength",
            [NSNumber numberWithFloat:spring.coefficient], @"coefficient",
            index1, @"p1", index2, @"p2", nil];
}

- (ANSpring *)springForParticleInfo:(NSDictionary *)info {
    NSInteger i1 = [[info objectForKey:@"p1"] integerValue];
    NSInteger i2 = [[info objectForKey:@"p2"] integerValue];
    ANParticle * p1 = [particles objectAtIndex:i1];
    ANParticle * p2 = [particles objectAtIndex:i2];
    ANSpring * spring = [[ANSpring alloc] initWithParticle:p1 toParticle:p2];
	spring.restLength = [[info objectForKey:@"restLength"] floatValue];
	spring.coefficient = [[info objectForKey:@"coefficient"] floatValue];
	return spring;
}

@end
