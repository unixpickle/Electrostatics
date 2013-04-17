//
//  ANParticleView.h
//  Electrostatics
//
//  Created by Alex Nichol on 2/18/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANVector2D.h"
#import "ANParticle.h"

typedef struct {
    CGPoint activePosition;
    ANVector2D activeVelocity;
} ANLiveParticleActive;

@interface ANLiveParticle : NSObject {
    ANLiveParticleActive activeState;
    BOOL isActive;
    ANParticle * baseParticle;
    
    BOOL isHighlighted;
    BOOL isErring;
}

@property (readwrite) ANLiveParticleActive activeState;
@property (readwrite, setter=setActive:) BOOL isActive;
@property (nonatomic, retain) ANParticle * baseParticle;
@property (readwrite, setter=setHighlighted:) BOOL isHighlighted;
@property (readwrite, setter=setErring:) BOOL isErring;

- (id)initWithParticle:(ANParticle *)particle;

- (void)beginActivity;
- (void)resignActivityAndReset;

- (ANVector2D)forceOnParticle:(ANLiveParticle *)particle;

- (CGPoint)position;

- (void)drawRect:(CGRect)rect context:(CGContextRef)context;

@end
