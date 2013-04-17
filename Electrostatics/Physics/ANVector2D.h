//
//  ANVector2D.h
//  Electrostatics
//
//  Created by Alex Nichol on 2/15/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef struct {
    CGFloat x;
    CGFloat y;
} ANVector2D;

ANVector2D ANVector2DMake(CGFloat x, CGFloat y);
ANVector2D ANVector2DAdd(ANVector2D v1, ANVector2D v2);
ANVector2D ANVector2DScale(ANVector2D v, CGFloat scalar);
CGFloat ANVector2DMagnitude(ANVector2D v);
CGFloat ANVector2DDot(ANVector2D v1, ANVector2D v2);
