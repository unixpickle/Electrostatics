//
//  ANSceneView.m
//  Electrostatics
//
//  Created by Alex Nichol on 2/18/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANSceneView.h"

@implementation ANSceneView

@synthesize particlesReference;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame particles:(NSMutableArray *)particles; {
    self = [super initWithFrame:frame];
    if (self) {
        particlesReference = particles;
        self.backgroundColor = [UIColor clearColor];
        [self setMultipleTouchEnabled:YES];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (ANLiveParticle * particle in particlesReference) {
        [particle drawRect:rect context:context];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    touchStart = nil;
    UITouch * touch = [touches anyObject];
    
    CGPoint location = [[touches anyObject] locationInView:self];
    ANLiveParticle * particle = nil;
    float distance = FLT_MAX;
    for (ANLiveParticle * aParticle in particlesReference) {
        ANVector2D dist = ANVector2DMake(aParticle.position.x - location.x, aParticle.position.y - location.y);
        float magnitude = ANVector2DMagnitude(dist);
        if (magnitude < distance && magnitude < 30) {
            particle = aParticle;
            distance = magnitude;
        }
    }
    if (!particle) return;
    touchStart = [NSDate date];
    if (touch.tapCount == 1) {
        selectedParticle = particle;
        particle.isHighlighted = YES;
        [self setNeedsDisplay];
        selectionBeginning = location;
        particleBeginning = selectedParticle.position;
    } else {
        [delegate sceneView:self editingParticle:particle.baseParticle];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (touchStart) {
        if ([[NSDate date] timeIntervalSinceDate:touchStart] > 1) {
            isDraggingVector = YES;
        } else {
            isDraggingVector = NO;
        }
        touchStart = nil;
    }
    if (selectedParticle) {
        CGPoint touchPoint = [[touches anyObject] locationInView:self];
        CGPoint newPoint = particleBeginning;
        newPoint.x += touchPoint.x - selectionBeginning.x;
        newPoint.y += touchPoint.y - selectionBeginning.y;
        selectedParticle.baseParticle.positionX = newPoint.x;
        selectedParticle.baseParticle.positionY = newPoint.y;
        [self setNeedsDisplay];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    touchStart = nil;
    selectedParticle.isHighlighted = NO;
    selectedParticle = nil;
    [self setNeedsDisplay];
}

@end
