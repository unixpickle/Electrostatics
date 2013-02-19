//
//  ANHomeViewController.m
//  Electrostatics
//
//  Created by Alex Nichol on 2/18/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANHomeViewController.h"

@interface ANHomeViewController ()

@end

@implementation ANHomeViewController

- (id)init {
    if ((self = [super init])) {
        self.view.backgroundColor = [UIColor blackColor];
        
        UIButton * openButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 147, 280, 86)];
        UIButton * newButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 247, 280, 86)];
        [openButton setBackgroundImage:[UIImage imageNamed:@"dotted_box.png"] forState:UIControlStateNormal];
        [newButton setBackgroundImage:[UIImage imageNamed:@"dotted_box.png"] forState:UIControlStateNormal];
        [openButton setBackgroundImage:[UIImage imageNamed:@"dotted_box_down.png"] forState:UIControlStateHighlighted];
        [newButton setBackgroundImage:[UIImage imageNamed:@"dotted_box_down.png"] forState:UIControlStateHighlighted];
        [openButton addTarget:self action:@selector(openButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [newButton addTarget:self action:@selector(newButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [newButton setTitle:@"New" forState:UIControlStateNormal];
        [openButton setTitle:@"Open" forState:UIControlStateNormal];
        [newButton.titleLabel setFont:[UIFont systemFontOfSize:25]];
        [openButton.titleLabel setFont:[UIFont systemFontOfSize:25]];
        [self.view addSubview:newButton];
        [self.view addSubview:openButton];
    }
    return self;
}

- (IBAction)openButtonPressed:(id)sender {
    ANOpenViewController * ovc = [[ANOpenViewController alloc] init];
    UINavigationController * nvc = [[UINavigationController alloc] initWithRootViewController:ovc];
    [self presentViewController:nvc animated:YES completion:NULL];
}

- (IBAction)newButtonPressed:(id)sender {
    ANCreateViewController * nvc = [[ANCreateViewController alloc] init];
    UINavigationController * navigation = [[UINavigationController alloc] initWithRootViewController:nvc];
    [self presentViewController:navigation animated:YES completion:NULL];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
