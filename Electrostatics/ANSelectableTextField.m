//
//  ANSelectableTextField.m
//  Electrostatics
//
//  Created by Alex Nichol on 2/19/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANSelectableTextField.h"

@implementation ANSelectableTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect outerFrame = CGRectInset(self.bounds, -10, -15);
    return CGRectContainsPoint(outerFrame, point);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
