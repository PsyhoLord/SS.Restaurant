//
//  MenuViewController.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Administrator on 6/6/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "MenuViewController.h"
#import "Alert.h"

#import "SWRevealViewController.h"
#import "SidebarViewController.h"
#import "SidebarViewController+ConfigurationForOtherViewControllers.h"

#import "MenuItemCell.h"
#import "MenuCategoryCell.h"

#import "MenuDataProvider.h"
#import "MenuModel.h"
#import "MenuCategoryModel.h"
#import "MenuItemModel.h"

#import "ItemDescriptionViewController.h"

#import "UserRole.h"

static NSString *const kMenuCategoryCellIdentifier  = @"MenuCategoryCellIdentifier";
static NSString *const kMenuItemCellIdentifier      = @"MenuItemCellIdentifier";
static NSString *const kSegueToItemdescription      = @"segue_description";

static const CGFloat kHeightForMenuCategoryCell = 50.0f;
static const CGFloat kHeightForMenuItemCell     = 70.0f;

@implementation MenuViewController
{
    IBOutlet UISwipeGestureRecognizer *_swipeGestureRecognizer; // need for pop self VC and go back
}

#pragma mark - Initialization

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [SidebarViewController setupSidebarConfigurationForViewController: self
                                                        sidebarButton: self.sidebarButton
                                                            isGesture: _isGestureForCallSidebar];
    
    [self setupRefreshControl];
    
    if ( _currentCategory == nil ) {
        [self loadMenuData];
    }
    
    [self setupGestureRecognizerConfiguration];
}

// set refresh control
- (void) setupRefreshControl
{
    [self.refreshControl addTarget: self action: @selector(loadMenuData) forControlEvents: UIControlEventAllEvents];
}

// set gesture
- (void) setupGestureRecognizerConfiguration
{
    if ( _swipeGestureRecognizer == nil ) {
        _swipeGestureRecognizer =
        [[UISwipeGestureRecognizer alloc] initWithTarget: self
                                                  action: @selector(handleSwipeGestureRecognizer:)];
    }
    [self.view addGestureRecognizer: _swipeGestureRecognizer];
}

#pragma mark - load data

// This method loads menu data from remote
- (void) loadMenuData
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    [self.refreshControl beginRefreshing];
    
    [MenuDataProvider loadMenuDataWithBlock:^(MenuModel *menuModel, NSError *error) {
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        _currentCategory = menuModel.rootMenuCategory;
        
        // method reloadData performs on main thread.
        dispatch_async( dispatch_get_main_queue(), ^{
            if ( error ) {
                [Alert showConnectionAlert];
            } else {
                [self.tableView reloadData];
                [self.refreshControl endRefreshing];
            }
        } );
    }];
    
}

#pragma mark - Table view data source

- (NSInteger) tableView: (UITableView *)tableView numberOfRowsInSection: (NSInteger)section
{
    // Return the number of rows in section.
    if ( [_currentCategory isCategories] ) {
        return [_currentCategory.categories count];
    } else {
        return [_currentCategory.items count];
    }
}

- (CGFloat) tableView: (UITableView *)tableView heightForRowAtIndexPath: (NSIndexPath *)indexPath
{
    return ( [_currentCategory isCategories] ? kHeightForMenuCategoryCell : kHeightForMenuItemCell );
}

// This method creates custom cell and sets data to it from model
- (UITableViewCell*) tableView: (UITableView*)tableView cellForRowAtIndexPath: (NSIndexPath*)indexPath
{
    if ( [_currentCategory isCategories] ) {
        MenuCategoryCell *menuCategoryCell = [tableView dequeueReusableCellWithIdentifier:
                                                       kMenuCategoryCellIdentifier];
        
        MenuCategoryModel *menuCategoryModel = _currentCategory.categories[indexPath.row];
        [menuCategoryCell drawCellWithModel: menuCategoryModel];
        
        return menuCategoryCell;
    } else {
        MenuItemCell *menuItemCell = [tableView dequeueReusableCellWithIdentifier:
                                               kMenuItemCellIdentifier];
        
        MenuItemModel *menuItemModel = _currentCategory.items[indexPath.row];
        [menuItemCell drawCellWithModel: menuItemModel];
        
        return menuItemCell;
    }

}

#pragma mark - Segues

// do smth before segue on next scrin recursively
- (void) prepareForSegue: (UIStoryboardSegue*)segue sender: (id)sender
{
    if( [segue.identifier isEqualToString: kSegueToItemdescription] ) {
        
        NSUInteger index = [self.tableView indexPathForCell:sender].row;
        MenuItemModel *menuItemModel = _currentCategory.items[ index];
        ItemDescriptionViewController *itemScreen = (ItemDescriptionViewController*)segue.destinationViewController;
        
        itemScreen.menuItemModel = menuItemModel;
        
    } else {
        MenuViewController *destinationMenuViewController =  segue.destinationViewController;
        
        NSUInteger selectedRow = [self.tableView indexPathForSelectedRow].row;
        MenuCategoryModel *selectedCategory = _currentCategory.categories[selectedRow];
        
        [destinationMenuViewController setTitle: selectedCategory.name];
        destinationMenuViewController->_currentCategory = selectedCategory;
    }
}

// return back to previous scrin
- (IBAction) handleSwipeGestureRecognizer: (UISwipeGestureRecognizer *)sender
{
    [self.navigationController popViewControllerAnimated: YES];
}

@end
