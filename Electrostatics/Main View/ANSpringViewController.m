//
//  ANSpringViewController.m
//  Electrostatics
//
//  Created by Alex Nichol on 4/16/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANSpringViewController.h"

@interface ANSpringViewController ()

@end

@implementation ANSpringViewController

@synthesize spring;
@synthesize delegate;

- (id)initWithSpring:(ANSpring *)theSpring {
    if ((self = [super initWithStyle:UITableViewStyleGrouped])) {
        spring = theSpring;
        
        self.title = @"Spring Editor";
        baseLength = [[ANSelectableTextField alloc] initWithFrame:CGRectMake(100, 10, 200, 30)];
        baseLength.returnKeyType = UIReturnKeyNext;
        baseLength.textColor = [UIColor blackColor];
        baseLength.delegate = self;
        coefficient = [[ANSelectableTextField alloc] initWithFrame:CGRectMake(100, 10, 200, 30)];
        coefficient.returnKeyType = UIReturnKeyNext;
        coefficient.textColor = [UIColor blackColor];
        coefficient.delegate = self;
        initialLength = [[ANSelectableTextField alloc] initWithFrame:CGRectMake(100, 10, 200, 30)];
        initialLength.returnKeyType = UIReturnKeyNext;
        initialLength.textColor = [UIColor colorWithWhite:0.3 alpha:1];
        initialLength.enabled = NO;
        
        baseLength.text = [NSString stringWithFormat:@"%f", spring.restLength];
        coefficient.text = [NSString stringWithFormat:@"%f", spring.coefficient];
        initialLength.text = [NSString stringWithFormat:@"%f",
                              [spring.p1 distanceToParticle:spring.p2]];
        
        deleteButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        deleteButton.frame = CGRectMake(0, 0, 300, 44);
        deleteButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        [deleteButton addTarget:self
                         action:@selector(deleteButtonPressed:)
               forControlEvents:UIControlEventTouchUpInside];
        [deleteButton setTitle:@"Delete" forState:UIControlStateNormal];
        
        resetLengthButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        resetLengthButton.frame = CGRectMake(0, 0, 300, 44);
        resetLengthButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        [resetLengthButton addTarget:self
                              action:@selector(resetButtonPressed:)
                    forControlEvents:UIControlEventTouchUpInside];
        [resetLengthButton setTitle:@"Reset Base Length" forState:UIControlStateNormal];
    }
    return self;
}

- (void)deleteButtonPressed:(id)sender {
    [delegate springViewController:self deletedSpring:spring];
}

- (void)resetButtonPressed:(id)sender {
    baseLength.text = [NSString stringWithFormat:@"%f",
                        [spring.p1 distanceToParticle:spring.p2]];
}

- (void)viewWillDisappear:(BOOL)animated {
    spring.restLength = baseLength.text.doubleValue;
    spring.coefficient = coefficient.text.doubleValue;
    [delegate springViewControllerDismissed:self];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == baseLength) {
        [coefficient becomeFirstResponder];
    } else {
        [baseLength becomeFirstResponder];
    }
    return NO;
}

#pragma mark - Table View -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) return 3;
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section != 0) {
        UITableViewCell * buttonCell = [tableView dequeueReusableCellWithIdentifier:@"ButtonCell"];
        if (!buttonCell) {
            buttonCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ButtonCell"];
        }
        if (indexPath.section == 1) {
            [buttonCell.contentView addSubview:resetLengthButton];
        } else {
            [buttonCell.contentView addSubview:deleteButton];
        }
        buttonCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return buttonCell;
    }
    static NSString * CellIdentifier = @"Cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.row == 0) {
        [cell.contentView addSubview:baseLength];
        cell.textLabel.text = @"Base X";
    } else if (indexPath.row == 1) {
        [cell.contentView addSubview:coefficient];
        cell.textLabel.text = @"Constant";
    } else if (indexPath.row == 2) {
        [cell.contentView addSubview:initialLength];
        cell.textLabel.text = @"Initail X";
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


@end
