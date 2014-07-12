//
//  WaiterMenuViewController.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Roman Sorochak on 7/12/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "WaiterMenuViewController.h"
#import "MenuItemCell.h"

#import "MenuCategoryModel.h"
#import "MenuItemModel.h"

#import "POrderItems.h"

@implementation WaiterMenuViewController

#pragma mark - handle of user click on cell

// logic of click on cell
- (void) tableView: (UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath
{
    if ( [[self.tableView cellForRowAtIndexPath: indexPath] isKindOfClass: [MenuItemCell class]] ) {
        [self.delegate didAddedOrderItem: self.currentCategory.items[indexPath.row]];
    }
}

- (void) prepareForSegue: (UIStoryboardSegue *)segue sender: (id)sender
{
    [super prepareForSegue: segue sender: sender];
    ((WaiterMenuViewController*)segue.destinationViewController).delegate = self.delegate;
}

- (IBAction) finishAddingItems: (id)sender
{
    [self.navigationController popToViewController: (UIViewController*)self.delegate
                                          animated: YES];
}


@end
