//
//  ANDraggableArrow.h
//  Electrostatics
//
//  Created by Nichol, Alexander on 2/21/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANDraggableLink.h"
#import "ANVector2D.h"

#define kANDraggableArrowTipSize 7

@interface ANDraggableArrow : ANDraggableLink {
    ANVector2D direction;
}

@property (readonly) ANVector2D direction;

@end
