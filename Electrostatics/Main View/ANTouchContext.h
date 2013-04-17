//
//  ANTouchContext.h
//  Electrostatics
//
//  Created by Alex Nichol on 4/16/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANLiveParticle.h"
#import "ANLiveSpring.h"
#import "ANDraggableLink.h"

#import "ANDraggableArrow.h"
#import "ANDraggableSpring.h"

#define kANTouchContextFingerOffset 0

typedef enum {
    ANTouchContextTypeSpring,
    ANTouchContextTypeParticle
} ANTouchContextType;

@interface ANTouchContext : NSObject {
    ANTouchContextType contextType;
    
    ANLiveSpring * selectedSpring;
    ANLiveParticle * selectedParticle;
    CGPoint selectionBeginning;
    CGPoint particleBeginning;
    
    NSDate * touchStart;
    BOOL isDraggingLink;
    ANDraggableLink * draggingLink;
    
    Class linkClass;
}

@property (readonly) ANTouchContextType contextType;
@property (readonly) ANLiveParticle * selectedParticle;
@property (readonly) ANLiveSpring * selectedSpring;
@property (readonly) BOOL isDraggingLink;
@property (readonly) ANDraggableLink * draggingLink;

- (id)initWithParticle:(ANLiveParticle *)initialParticle
                 point:(CGPoint)point
             linkClass:(Class)linkClass;
- (id)initWithSpring:(ANLiveSpring *)spring;

- (void)handleTouchMoved:(CGPoint)point;
- (void)handleTouchEnded;

@end
