//
//  ANAppDelegate.h
//  Electrostatics
//
//  Created by Alex Nichol on 2/15/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANHomeViewController.h"

@interface ANAppDelegate : UIResponder <UIApplicationDelegate> {
    ANHomeViewController * homeview;
}

@property (strong, nonatomic) UIWindow * window;
@property (readonly) ANHomeViewController * homeview;

@end
