//
//  ANDraggableArrow.h
//  Electrostatics
//
//  Created by Nichol, Alexander on 2/21/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANVector2D.h"

@interface ANDraggableArrow : NSObject {
    CGPoint initialPoint;
    ANVector2D direction;
    NSDate * fadeStart;
}

@property (readonly) CGPoint initialPoint;
@property (readwrite) ANVector2D direction;

- (BOOL)shouldDestroy;
- (void)drawInContext:(CGContextRef)context;
- (void)beginOutfade;

@end
