//
//  ANSpringViewController.h
//  Electrostatics
//
//  Created by Alex Nichol on 4/16/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANSpring.h"
#import "ANSelectableTextField.h"

@class ANSpringViewController;

@protocol ANSpringViewControllerDelegate <NSObject>

- (void)springViewControllerDismissed:(ANSpringViewController *)svc;
- (void)springViewController:(ANSpringViewController *)svc deletedSpring:(ANSpring *)spring;

@end

@interface ANSpringViewController : UITableViewController <UITextFieldDelegate> {
    UITextField * baseLength;
    UITextField * coefficient;
    UITextField * initialLength;
    UIButton * deleteButton;
    UIButton * resetLengthButton;
    
    ANSpring * spring;
    __weak id<ANSpringViewControllerDelegate> delegate;
}

@property (readonly) ANSpring * spring;
@property (nonatomic, weak) id<ANSpringViewControllerDelegate> delegate;

- (id)initWithSpring:(ANSpring *)theSpring;
- (void)deleteButtonPressed:(id)sender;
- (void)resetButtonPressed:(id)sender;

@end
