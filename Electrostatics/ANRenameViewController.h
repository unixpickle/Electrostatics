//
//  ANRenameViewController.h
//  Electrostatics
//
//  Created by Alex Nichol on 2/19/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANDocumentManager.h"
#import "ANSelectableTextField.h"

@interface ANRenameViewController : UITableViewController <UITextFieldDelegate> {
    UIBarButtonItem * saveButton;
    UIBarButtonItem * cancelButton;
    UITextField * nameField;
    ANDocumentInfo * docInfo;
}

- (id)initWithDocumentInfo:(ANDocumentInfo *)info;

- (void)saveButtonPressed:(id)sender;
- (void)cancelButtonPressed:(id)sender;

@end
