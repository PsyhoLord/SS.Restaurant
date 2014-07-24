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
#import "UIViewController+BackgroundImage.h"

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
static const CGFloat kHeightForMenuItemCell     = 205.0f;

@interface UITableViewController(method)
- (void) setupRefreshControl:(SEL)method;
@end

@implementation UITableViewController(method)

// Sets refresh control
- (void) setupRefreshControl:(SEL)method
{
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor purpleColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    
    [self.refreshControl addTarget: self action: method forControlEvents: UIControlEventAllEvents];
}

@end

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
    
    if( self == [self.navigationController.viewControllers objectAtIndex:0] ){
        [self setupRefreshControl:@selector(loadMenuData)];
    }
    
    [UIViewController setBackgroundImage:self ];
    
    if ( _currentCategory == nil ) {
        [self loadMenuData];
    }
    
    [self setupGestureRecognizerConfiguration];
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
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible: YES];
    //    [self.refreshControl beginRefreshing];
    
    
    [MenuDataProvider loadMenuDataWithBlock:^(MenuModel *menuModel, NSError *error) {
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible: NO];
        
        _currentCategory = menuModel.rootMenuCategory;
        
        // method reloadData performs on main thread.
        
        if ( error ) {
            [Alert showConnectionAlert];
        } else {
            [self.tableView reloadData];
            
            if(self.refreshControl){

                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    [formatter setDateFormat:@"MMM d, h:mm a"];
                    NSString *title = [NSString stringWithFormat:@"Last update: %@", [formatter stringFromDate:[NSDate date]]];
                    NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor whiteColor]
                                                                                forKey:NSForegroundColorAttributeName];
                    NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
                    self.refreshControl.attributedTitle = attributedTitle;
                    [self.refreshControl endRefreshing];
            }
        }
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
        menuCategoryCell.backgroundColor = [UIColor colorWithRed:0.99 green:0.99 blue:0.99 alpha:0.3];
        
        return menuCategoryCell;
    } else {
        MenuItemCell *menuItemCell = [tableView dequeueReusableCellWithIdentifier:
                                      kMenuItemCellIdentifier];
        
        MenuItemModel *menuItemModel = _currentCategory.items[indexPath.row];
        [menuItemCell drawCellWithModel: menuItemModel];
        
        menuItemCell.backgroundColor = [UIColor colorWithRed:0.99 green:0.99 blue:0.99 alpha:0.6];
        
        return menuItemCell;
    }
    
}

#pragma mark - Segues

// do smth before segue on next scrin recursively
- (void) prepareForSegue: (UIStoryboardSegue*)segue sender: (id)sender
{
    if( [segue.identifier isEqualToString: kSegueToItemdescription] ) {
        
        NSUInteger index = [self.tableView indexPathForCell:sender].row;
        ItemDescriptionViewController *itemScreen = (ItemDescriptionViewController*)segue.destinationViewController;
        
        itemScreen.items = _currentCategory.items;
        itemScreen.index = index;
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
