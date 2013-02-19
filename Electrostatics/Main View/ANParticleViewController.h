//
//  ANParticleViewController.h
//  Electrostatics
//
//  Created by Alex Nichol on 2/18/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANParticle.h"

@class ANParticleViewController;

@protocol ANParticleViewControllerDelegate <NSObject>

- (void)particleViewControllerDismissed:(ANParticleViewController *)pvc;

@end

@interface ANParticleViewController : UITableViewController {
    UITextField * xVelocity;
    UITextField * yVelocity;
    UITextField * mass;
    ANParticle * particle;
    
    __weak id<ANParticleViewControllerDelegate> delegate;
}

@property (nonatomic, weak) id<ANParticleViewControllerDelegate> delegate;

- (id)initWithParticle:(ANParticle *)particle;

@end
