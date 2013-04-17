//
//  ANTouchContext.m
//  Electrostatics
//
//  Created by Alex Nichol on 4/16/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANTouchContext.h"

@implementation ANTouchContext

@synthesize contextType;
@synthesize selectedParticle;
@synthesize selectedSpring;
@synthesize isDraggingLink;
@synthesize draggingLink;

- (id)initWithParticle:(ANLiveParticle *)initialParticle
                 point:(CGPoint)point
             linkClass:(Class)theClass {
    if ((self = [super init])) {
        contextType = ANTouchContextTypeParticle;

        touchStart = [NSDate date];
        selectedParticle = initialParticle;
        
        selectedParticle.isHighlighted = YES;
        selectionBeginning = point;
        particleBeginning = selectedParticle.position;
        
        linkClass = theClass;
    }
    return self;
}

- (id)initWithSpring:(ANLiveSpring *)spring {
    if ((self = [super init])) {
        contextType = ANTouchContextTypeSpring;
        selectedSpring = spring;
        selectedSpring.isHighlighted = YES;
    }
    return self;
}

- (void)handleTouchMoved:(CGPoint)point {
    if (contextType == ANTouchContextTypeSpring) {
        if ([selectedSpring closestDistanceToPoint:point] > 30) {
            selectedSpring.isHighlighted = NO;
        } else selectedSpring.isHighlighted = YES;
        return;
    }
    if (touchStart) {
        if ([[NSDate date] timeIntervalSinceDate:touchStart] > 0.5) {
            isDraggingLink = YES;
            draggingLink = [[linkClass alloc] initWithPoint:particleBeginning];
        } else {
            isDraggingLink = NO;
        }
        touchStart = nil;
    }
    point.y -= kANTouchContextFingerOffset;
    if (selectedParticle && !isDraggingLink) {
        [self handleParticleDrag:point];
    } else if (selectedParticle && isDraggingLink) {
        [self handleDraggingLinkMove:point];
    }
}

- (void)handleTouchEnded {
    if (contextType == ANTouchContextTypeSpring) {
        if (selectedSpring.isHighlighted) {
            selectedSpring.isHighlighted = NO;
        }
    } else {
        isDraggingLink = NO;
        
        selectedParticle.isHighlighted = NO;
        selectedParticle = nil;
    }
}

#pragma mark - Private -

- (void)handleDraggingLinkMove:(CGPoint)touchPoint {
    draggingLink.endPoint = touchPoint;
}

- (void)handleParticleDrag:(CGPoint)touchPoint {
    CGPoint newPoint = particleBeginning;
    newPoint.x += touchPoint.x - selectionBeginning.x;
    newPoint.y += touchPoint.y - selectionBeginning.y;
    selectedParticle.baseParticle.positionX = newPoint.x;
    selectedParticle.baseParticle.positionY = newPoint.y;
}


@end
