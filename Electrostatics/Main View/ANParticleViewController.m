//
//  ANParticleViewController.m
//  Electrostatics
//
//  Created by Alex Nichol on 2/18/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANParticleViewController.h"

@interface ANParticleViewController ()

@end

@implementation ANParticleViewController

@synthesize delegate;

- (id)initWithParticle:(ANParticle *)aParticle {
    if ((self = [super initWithStyle:UITableViewStyleGrouped])) {
        particle = aParticle;
        self.title = @"Particle Editor";
        xVelocity = [[ANSelectableTextField alloc] initWithFrame:CGRectMake(100, 10, 200, 30)];
        xVelocity.returnKeyType = UIReturnKeyNext;
        xVelocity.textColor = [UIColor blackColor];
        xVelocity.delegate = self;
        yVelocity = [[ANSelectableTextField alloc] initWithFrame:CGRectMake(100, 10, 200, 30)];
        yVelocity.returnKeyType = UIReturnKeyNext;
        yVelocity.textColor = [UIColor blackColor];
        yVelocity.delegate = self;
        mass = [[ANSelectableTextField alloc] initWithFrame:CGRectMake(100, 10, 200, 30)];
        mass.returnKeyType = UIReturnKeyNext;
        mass.textColor = [UIColor blackColor];
        mass.delegate = self;
        
        deleteButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        deleteButton.frame = CGRectMake(0, 0, 300, 44);
        deleteButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        [deleteButton addTarget:self
                         action:@selector(deleteButtonPressed:)
               forControlEvents:UIControlEventTouchUpInside];
        [deleteButton setTitle:@"Delete" forState:UIControlStateNormal];
        
        fixedSwitch = [[UISwitch alloc] init];
        [fixedSwitch setOn:particle.fixedVelocity];
        [fixedSwitch addTarget:self
                        action:@selector(fixedSwitchChanged:)
              forControlEvents:UIControlEventValueChanged];

        
        xVelocity.text = [NSString stringWithFormat:@"%0.02f", particle.velocityX];
        yVelocity.text = [NSString stringWithFormat:@"%0.02f", particle.velocityY];
        mass.text = [NSString stringWithFormat:@"%0.02f", particle.constant];
    }
    return self;
}

- (void)deleteButtonPressed:(id)sender {
    [delegate particleViewController:self deleteParticle:particle];
}

- (void)fixedSwitchChanged:(id)sender {
    particle.fixedVelocity = fixedSwitch.isOn;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == xVelocity) {
        [yVelocity becomeFirstResponder];
    } else if (textField == yVelocity) {
        [mass becomeFirstResponder];
    } else {
        [xVelocity becomeFirstResponder];
    }
    return NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    particle.velocityX = xVelocity.text.doubleValue;
    particle.velocityY = yVelocity.text.doubleValue;
    particle.constant = mass.text.doubleValue;
    [delegate particleViewControllerDismissed:self];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) return 4;
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        UITableViewCell * buttonCell = [tableView dequeueReusableCellWithIdentifier:@"ButtonCell"];
        if (!buttonCell) {
            buttonCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ButtonCell"];
        }
        [buttonCell.contentView addSubview:deleteButton];
        buttonCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return buttonCell;
    }
    static NSString * CellIdentifier = @"Cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.row == 0) {
        [cell.contentView addSubview:xVelocity];
        cell.textLabel.text = @"X Velocity";
    } else if (indexPath.row == 1) {
        [cell.contentView addSubview:yVelocity];
        cell.textLabel.text = @"Y Velocity";
    } else if (indexPath.row == 2) {
        [cell.contentView addSubview:mass];
        cell.textLabel.text = @"Mass";
    } else if (indexPath.row == 3) {
        cell.accessoryView = fixedSwitch;
        cell.textLabel.text = @"Fixed Velocity";
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

@end
