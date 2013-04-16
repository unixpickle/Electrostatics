//
//  ANSpring.h
//  Electrostatics
//
//  Created by Alex Nichol on 4/16/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANParticle.h"

@interface ANSpring : NSObject {
    ANParticle * p1;
    ANParticle * p2;
    CGFloat restLength;
    CGFloat coefficient;
}

@property (nonatomic, retain) ANParticle * p1;
@property (nonatomic, retain) ANParticle * p2;
@property (readwrite) CGFloat restLength;
@property (readwrite) CGFloat coefficient;

- (id)initWithParticle:(ANParticle *)theP1 toParticle:(ANParticle *)theP2;
- (ANVector2D)forceOnP1;
- (ANVector2D)forceOnP2;

@end
