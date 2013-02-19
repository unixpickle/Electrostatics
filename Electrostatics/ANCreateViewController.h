//
//  ANCreateViewController.h
//  Electrostatics
//
//  Created by Alex Nichol on 2/18/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANDocumentManager.h"
#import "ANDocumentViewController.h"

@interface ANCreateViewController : UITableViewController <UITextFieldDelegate> {
    UIBarButtonItem * createButton;
    UIBarButtonItem * cancelButton;
    UITextField * nameField;
}

- (void)createButtonPressed:(id)sender;
- (void)cancelButtonPressed:(id)sender;

@end
