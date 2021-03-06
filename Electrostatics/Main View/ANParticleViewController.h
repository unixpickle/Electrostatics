//
//  ANParticleViewController.h
//  Electrostatics
//
//  Created by Alex Nichol on 2/18/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANParticle.h"
#import "ANSelectableTextField.h"

@class ANParticleViewController;

@protocol ANParticleViewControllerDelegate <NSObject>

- (void)particleViewControllerDismissed:(ANParticleViewController *)pvc;
- (void)particleViewController:(ANParticleViewController *)pvc deleteParticle:(ANParticle *)particle;

@end

@interface ANParticleViewController : UITableViewController <UITextFieldDelegate> {
    UITextField * xVelocity;
    UITextField * yVelocity;
    UITextField * mass;
    UIButton * deleteButton;
    UISwitch * fixedSwitch;
    ANParticle * particle;
    
    __weak id<ANParticleViewControllerDelegate> delegate;
}

@property (nonatomic, weak) id<ANParticleViewControllerDelegate> delegate;

- (id)initWithParticle:(ANParticle *)particle;
- (void)deleteButtonPressed:(id)sender;
- (void)fixedSwitchChanged:(id)sender;

@end
