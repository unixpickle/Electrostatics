//
//  ANOpenViewController.h
//  Electrostatics
//
//  Created by Alex Nichol on 2/18/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANDocumentManager.h"
#import "ANDocumentViewController.h"

@interface ANOpenViewController : UITableViewController {
    ANDocumentManager * manager;
    UIBarButtonItem * editButton;
    UIBarButtonItem * cancelButton;
    UIBarButtonItem * doneButton;
}

- (void)editButtonPressed:(id)sender;
- (void)cancelButtonPressed:(id)sender;
- (void)doneButtonPressed:(id)sender;

@end
