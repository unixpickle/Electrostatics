//
//  ANSceneView.m
//  Electrostatics
//
//  Created by Alex Nichol on 2/18/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANSceneView.h"

@interface ANSceneView (Private)

- (void)requestRedraw;
- (void)handleParticleDrag:(CGPoint)touchPoint;

- (void)handleDraggingLinkMove:(CGPoint)touchPoint;
- (void)handleDraggingLinkEnd:(CGPoint)touchPoint;

@end

@implementation ANSceneView

@synthesize isAnimating;
@synthesize particlesReference;
@synthesize delegate;
@synthesize draggableClass;

- (id)initWithFrame:(CGRect)frame particles:(NSMutableArray *)particles; {
    self = [super initWithFrame:frame];
    if (self) {
        draggableClass = [ANDraggableSpring class];
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
    if (draggingLink) {
        if ([draggingLink shouldDestroy]) {
            draggingLink = nil;
        } else {
            [draggingLink drawInContext:context];
            if (!isDraggingLink) {
                [self performSelector:@selector(requestRedraw) withObject:nil afterDelay:(1.0 / 30.0)];
            }
        }
    }
}

#pragma mark - Touches -

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (isAnimating) return;
#ifndef DISABLE_DRAGGABLE_VECTOR
    touchStart = nil;
#endif
    UITouch * touch = [touches anyObject];
    
    CGPoint location = [[touches anyObject] locationInView:self];
    location.y -= kANSceneViewTouchFingerOffset;
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
    if (isAnimating) return;
    
    if (touchStart) {
        if ([[NSDate date] timeIntervalSinceDate:touchStart] > 0.5) {
            isDraggingLink = YES;
            draggingLink = [[draggableClass alloc] initWithPoint:particleBeginning];
        } else {
            isDraggingLink = NO;
        }
        touchStart = nil;
    }
    CGPoint touchPoint = [[touches anyObject] locationInView:self];
    touchPoint.y -= kANSceneViewTouchFingerOffset;
    if (selectedParticle && !isDraggingLink) {
        [self handleParticleDrag:touchPoint];
    } else if (selectedParticle && isDraggingLink) {
        [self handleDraggingLinkMove:touchPoint];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (isAnimating) return;
    if (isDraggingLink) {
        [self handleDraggingLinkEnd:[[touches anyObject] locationInView:self]];
        isDraggingLink = NO;
    }
    touchStart = nil;
    selectedParticle.isHighlighted = NO;
    selectedParticle = nil;
    [self setNeedsDisplay];
}

#pragma mark - Private -

- (void)requestRedraw {
    [self setNeedsDisplay];
}

- (void)handleParticleDrag:(CGPoint)touchPoint {
    CGPoint newPoint = particleBeginning;
    newPoint.x += touchPoint.x - selectionBeginning.x;
    newPoint.y += touchPoint.y - selectionBeginning.y;
    selectedParticle.baseParticle.positionX = newPoint.x;
    selectedParticle.baseParticle.positionY = newPoint.y;
    [self setNeedsDisplay];
}

#pragma mark Arrow Dragging

- (void)handleDraggingLinkMove:(CGPoint)touchPoint {
    draggingLink.endPoint = touchPoint;
    [self setNeedsDisplay];
}

- (void)handleDraggingLinkEnd:(CGPoint)touchPoint {
    [draggingLink beginOutfade];
    //selectedParticle.baseParticle.velocityX = arrow.direction.x;
    //selectedParticle.baseParticle.velocityY = arrow.direction.y;
}

@end
