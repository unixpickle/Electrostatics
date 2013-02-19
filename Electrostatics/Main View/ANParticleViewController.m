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
        xVelocity = [[UITextField alloc] initWithFrame:CGRectMake(100, 10, 95, 30)];
        xVelocity.returnKeyType = UIReturnKeyNext;
        xVelocity.textColor = [UIColor blackColor];
        yVelocity = [[UITextField alloc] initWithFrame:CGRectMake(100, 10, 95, 30)];
        yVelocity.returnKeyType = UIReturnKeyNext;
        yVelocity.textColor = [UIColor blackColor];
        mass = [[UITextField alloc] initWithFrame:CGRectMake(100, 10, 95, 30)];
        mass.returnKeyType = UIReturnKeyNext;
        mass.textColor = [UIColor blackColor];
        
        xVelocity.text = [NSString stringWithFormat:@"%0.02f", particle.velocityX];
        yVelocity.text = [NSString stringWithFormat:@"%0.02f", particle.velocityY];
        mass.text = [NSString stringWithFormat:@"%0.02f", particle.constant];
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated {
    particle.velocityX = xVelocity.text.doubleValue;
    particle.velocityY = yVelocity.text.doubleValue;
    particle.constant = mass.text.doubleValue;
    [delegate particleViewControllerDismissed:self];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * CellIdentifier = @"Cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.row == 0) {
        [cell.contentView addSubview:xVelocity];
        cell.textLabel.text = @"X Velocity";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    } else if (indexPath.row == 1) {
        [cell.contentView addSubview:yVelocity];
        cell.textLabel.text = @"Y Velocity";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    } else if (indexPath.row == 2) {
        [cell.contentView addSubview:mass];
        cell.textLabel.text = @"Mass";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    
    return cell;
}

@end
