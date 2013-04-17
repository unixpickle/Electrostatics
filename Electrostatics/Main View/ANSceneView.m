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
- (void)handleDraggingLinkEnd:(CGPoint)touchPoint;

- (id)closestLiveObjectToPoint:(CGPoint)point;
- (ANLiveParticle *)particleCloseToPoint:(CGPoint)point;

@end

@implementation ANSceneView

@synthesize isAnimating;
@synthesize particlesReference;
@synthesize springsReference;
@synthesize delegate;
@synthesize draggableClass;

- (id)initWithFrame:(CGRect)frame particles:(NSMutableArray *)particles springs:(NSMutableArray *)springs {
    self = [super initWithFrame:frame];
    if (self) {
        draggableClass = [ANDraggableSpring class];
        particlesReference = particles;
        springsReference = springs;
        self.backgroundColor = [UIColor clearColor];
        [self setMultipleTouchEnabled:YES];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    ANLiveParticle * topParticle = touchContext.selectedParticle;
    for (ANLiveSpring * spring in springsReference) {   
        [spring drawInContext:context];
    }
    for (ANLiveParticle * particle in particlesReference) {
        if (particle != topParticle) [particle drawRect:rect context:context];
    }
    [topParticle drawRect:rect context:context];
    if (touchContext.draggingLink) {
        if ([touchContext.draggingLink shouldDestroy]) {
            touchContext = nil;
        } else {
            [touchContext.draggingLink drawInContext:context];
            if (!touchContext.isDraggingLink) {
                [self performSelector:@selector(requestRedraw) withObject:nil afterDelay:(1.0 / 30.0)];
            }
        }
    }
}

#pragma mark - Touches -

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (isAnimating) return;
    
    UITouch * touch = [touches anyObject];
    
    CGPoint location = [[touches anyObject] locationInView:self];
    location.y -= kANTouchContextFingerOffset;
    id object = [self closestLiveObjectToPoint:location];
    if (!object) return;
    
    if ([object isKindOfClass:[ANLiveSpring class]]) {
        touchContext = [[ANTouchContext alloc] initWithSpring:object];
    } else if ([object isKindOfClass:[ANLiveParticle class]]) {
        ANLiveParticle * particle = object;
        if (touch.tapCount > 1) {
            [delegate sceneView:self editingParticle:particle.baseParticle];
        } else {
            touchContext = [[ANTouchContext alloc] initWithParticle:particle
                                                              point:location
                                                          linkClass:draggableClass];
        }
    }
    
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (isAnimating) return;
    [touchContext handleTouchMoved:[[touches anyObject] locationInView:self]];
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (isAnimating) return;
    if (touchContext.contextType == ANTouchContextTypeSpring) {
        if (touchContext.selectedSpring.isHighlighted) {
            [delegate sceneView:self editingSpring:touchContext.selectedSpring.spring];
        }
    }
    if (touchContext.isDraggingLink) {
        [self handleDraggingLinkEnd:[[touches anyObject] locationInView:self]];
    }
    [touchContext handleTouchEnded];
    [self setNeedsDisplay];
}

#pragma mark - Private -

- (void)requestRedraw {
    [self setNeedsDisplay];
}

#pragma mark Arrow Dragging

- (void)handleDraggingLinkEnd:(CGPoint)touchPoint {
    [touchContext.draggingLink beginOutfade];
    if (draggableClass == [ANDraggableArrow class]) {
        ANDraggableArrow * arrow = (ANDraggableArrow *)touchContext.draggingLink;
        touchContext.selectedParticle.baseParticle.velocityX = arrow.direction.x;
        touchContext.selectedParticle.baseParticle.velocityY = arrow.direction.y;
    } else if (draggableClass == [ANDraggableSpring class]) {
        ANDraggableSpring * spring = (ANDraggableSpring *)touchContext.draggingLink;
        ANLiveParticle * destination = [self particleCloseToPoint:spring.endPoint];
        ANLiveParticle * start = touchContext.selectedParticle;
        if (!destination || start == destination) return;
        [delegate sceneView:self springFrom:start to:destination];
    }
}

#pragma mark - Touch Detection -

- (id)closestLiveObjectToPoint:(CGPoint)point {
    id object = nil;
    float distance = 30;
    for (ANLiveParticle * aParticle in particlesReference) {
        ANVector2D dist = ANVector2DMake(aParticle.position.x - point.x, aParticle.position.y - point.y);
        float magnitude = ANVector2DMagnitude(dist);
        if (magnitude < distance) {
            object = aParticle;
            distance = magnitude;
        }
    }
    if (object && distance < 25) return object;
    for (ANLiveSpring * spring in springsReference) {
        float closest = [spring closestDistanceToPoint:point];
        if (closest / 2 < distance) {
            object = spring;
            distance = closest;
        }
    }
    return object;
}

- (ANLiveParticle *)particleCloseToPoint:(CGPoint)point {
    ANLiveParticle * particle = nil;
    float distance = 30;
    for (ANLiveParticle * aParticle in particlesReference) {
        ANVector2D dist = ANVector2DMake(aParticle.position.x - point.x, aParticle.position.y - point.y);
        float magnitude = ANVector2DMagnitude(dist);
        if (magnitude < distance) {
            particle = aParticle;
            distance = magnitude;
        }
    }
    return particle;
}

@end
