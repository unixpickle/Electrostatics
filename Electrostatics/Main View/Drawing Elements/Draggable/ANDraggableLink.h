//
//  ANDraggableLink.h
//  Electrostatics
//
//  Created by Alex Nichol on 4/16/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kANDraggableLinkFadeTime 0.2

@interface ANDraggableLink : NSObject {
    CGPoint initialPoint;
    CGPoint endPoint;
    
    // animation
    NSDate * fadeStart;
}

@property (readonly) CGPoint initialPoint;
@property (readwrite) CGPoint endPoint;

- (id)initWithPoint:(CGPoint)theInitPoint;

- (BOOL)shouldDestroy;
- (void)drawInContext:(CGContextRef)context;
- (void)beginOutfade;

@end
