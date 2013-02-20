//
//  ANRenameViewController.m
//  Electrostatics
//
//  Created by Alex Nichol on 2/19/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANRenameViewController.h"

@interface ANRenameViewController ()

@end

@implementation ANRenameViewController

- (id)initWithDocumentInfo:(ANDocumentInfo *)info {
    if ((self = [super initWithStyle:UITableViewStyleGrouped])) {
        self.title = @"Rename";
        docInfo = info;
        
        saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                      style:UIBarButtonItemStyleDone
                                                     target:self action:@selector(saveButtonPressed:)];
        cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
                                                        style:UIBarButtonItemStyleBordered
                                                       target:self action:@selector(cancelButtonPressed:)];
        self.navigationItem.leftBarButtonItem = cancelButton;
        self.navigationItem.rightBarButtonItem = saveButton;
        nameField = [[ANSelectableTextField alloc] initWithFrame:CGRectMake(90, 10, 105, 30)];
        nameField.returnKeyType = UIReturnKeyNext;
        nameField.delegate = self;
        nameField.textColor = [UIColor blackColor];
        nameField.text = docInfo.documentTitle;
    }
    return self;
}

- (void)saveButtonPressed:(id)sender {
    [[ANDocumentManager sharedDocumentManager] renameDocument:docInfo title:nameField.text];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)cancelButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * CellIdentifier = @"Cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    [cell.contentView addSubview:nameField];
    cell.textLabel.text = @"Name";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

@end
