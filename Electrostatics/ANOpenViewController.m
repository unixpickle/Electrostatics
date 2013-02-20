//
//  ANOpenViewController.m
//  Electrostatics
//
//  Created by Alex Nichol on 2/18/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANOpenViewController.h"

@interface ANOpenViewController ()

@end

@implementation ANOpenViewController

- (id)init {
    if ((self = [super initWithStyle:UITableViewStylePlain])) {
        editButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit"
                                                      style:UIBarButtonItemStyleBordered
                                                     target:self
                                                     action:@selector(editButtonPressed:)];
        cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
                                                      style:UIBarButtonItemStyleBordered
                                                     target:self
                                                     action:@selector(cancelButtonPressed:)];
        self.navigationItem.leftBarButtonItem = editButton;
        doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone
                                                     target:self
                                                     action:@selector(doneButtonPressed:)];
        self.navigationItem.rightBarButtonItem = doneButton;
        
        manager = [ANDocumentManager sharedDocumentManager];
        
        self.tableView.allowsSelectionDuringEditing = YES;
        
        self.title = @"Open";
    }
    return self;
}

- (void)editButtonPressed:(id)sender {
    [self.navigationItem setLeftBarButtonItem:cancelButton
                                      animated:YES];
    [self.navigationItem setRightBarButtonItem:nil animated:YES];
    [self.tableView setEditing:YES animated:YES];
}

- (void)cancelButtonPressed:(id)sender {
    [self.navigationItem setLeftBarButtonItem:editButton
                                      animated:YES];
    [self.navigationItem setRightBarButtonItem:doneButton animated:YES];
    [self.tableView setEditing:NO animated:YES];
}

- (void)doneButtonPressed:(id)sender {
    [self.parentViewController dismissViewControllerAnimated:YES completion:NULL];
}

- (void)viewDidAppear:(BOOL)animated {
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return manager.documents.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * CellIdentifier = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [[manager.documents objectAtIndex:indexPath.row] documentTitle];
    
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [tableView beginUpdates];
        [manager deleteDocument:[manager.documents objectAtIndex:indexPath.row]];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [tableView endUpdates];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
    }
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    [tableView beginUpdates];
    [manager moveDocumentAtIndex:fromIndexPath.row toIndex:toIndexPath.row];
    [tableView moveRowAtIndexPath:fromIndexPath toIndexPath:toIndexPath];
    [tableView endUpdates];
}

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEditing]) {
        ANDocumentInfo * info = [manager.documents objectAtIndex:indexPath.row];
        ANRenameViewController * rvc = [[ANRenameViewController alloc] initWithDocumentInfo:info];
        [self.navigationController pushViewController:rvc animated:YES];
    } else {
        ANDocumentInfo * info = [manager.documents objectAtIndex:indexPath.row];
        ANDocumentViewController * vc = [[ANDocumentViewController alloc] initWithDocumentInfo:info];
        UINavigationController * controller = [[UINavigationController alloc] initWithRootViewController:vc];
        [self presentViewController:controller animated:YES completion:NULL];
    }
}

@end
