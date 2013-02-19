//
//  ANVector2D.m
//  Electrostatics
//
//  Created by Alex Nichol on 2/15/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANVector2D.h"

ANVector2D ANVector2DMake(CGFloat x, CGFloat y) {
    ANVector2D v;
    v.x = x;
    v.y = y;
    return v;
}

ANVector2D ANVector2DAdd(ANVector2D v1, ANVector2D v2) {
    ANVector2D sum = v1;
    sum.x += v2.x;
    sum.y += v2.y;
    return sum;
}

ANVector2D ANVector2DScale(ANVector2D v, CGFloat scalar) {
    ANVector2D newVec = v;
    newVec.x *= scalar;
    newVec.y *= scalar;
    return newVec;
}

CGFloat ANVector2DMagnitude(ANVector2D v) {
    return sqrt(v.x*v.x + v.y*v.y);
}
