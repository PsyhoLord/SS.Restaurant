//
//  MenuViewController.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Administrator on 6/6/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuItemCell.h"
#import "MenuCategoryCell.h"
#import "MenuDataProvider.h"
#import "MenuModel.h"
#import "MenuCategoryModel.h"
#import "MenuItemModel.h"
#import "Alert.h"
#import "ItemDescription.h"

static NSString *const menuCategoryCellIdentifier   = @"menuCategoryCellIdentifier";
static NSString *const menuItemCellIdentifier       = @"menuItemCellIdentifier";
static const NSUInteger numberOfSectionsInTableView = 1;




@implementation MenuViewController
{
    MenuCategoryModel *_currentCategory;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupRefreshControl];
    
    if ( _currentCategory == nil ) {
//        [self performSelectorOnMainThread:@selector(loadMenuData) withObject:self waitUntilDone:NO];
        [self loadMenuData];
    }
}

// This method loads menu data from remote
- (void)loadMenuData
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    [self.refreshControl beginRefreshing];
    
    [MenuDataProvider loadMenuDataWithBlock:^(MenuModel *menuModel, NSError *error) {
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        _currentCategory = menuModel.rootMenuCategory;
        
        //            method reloadData performs on main thread.
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


- (void) setupRefreshControl
{
    [self.refreshControl addTarget:self action:@selector(loadMenuData) forControlEvents:UIControlEventAllEvents];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return numberOfSectionsInTableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in section.
    if ( [_currentCategory isCategories] ) {
        return [_currentCategory.categories count];
    } else {
        return [_currentCategory.items count];
    }
}

//Method for row height setting (for items and for category)
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( [_currentCategory isItems] ) {
        return [MenuItemCell rowHeightForCell];
        //rowHeightForMenuItemCell;
    } else {
        return [MenuCategoryCell rowHeightForCell];
        //rowHeightForMenuCategoryCell;
    }
}

// This method creates custom cell and sets data to it from model
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( [_currentCategory isCategories] ) {
        
        MenuCategoryCell *menuCategoryCell = [tableView dequeueReusableCellWithIdentifier:menuCategoryCellIdentifier];
        
        if ( menuCategoryCell == nil ) {
            
            menuCategoryCell = [[MenuCategoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:menuCategoryCellIdentifier];
            
            MenuCategoryModel *menuCategoryModel = [_currentCategory.categories objectAtIndex:indexPath.row];
            
            [menuCategoryCell drawCellWithModel:menuCategoryModel];
            
        }
        return menuCategoryCell;
    } else {
        
        MenuItemCell *menuItemCell = [tableView dequeueReusableCellWithIdentifier:menuItemCellIdentifier];
        
        if ( menuItemCell == nil ) {
            
            menuItemCell = [[MenuItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:menuItemCellIdentifier];
        
            MenuItemModel *menuItemModel = [_currentCategory.items objectAtIndex:indexPath.row];
            
            [menuItemCell drawCellWithModel:menuItemModel];
            
            //[[menuItemCell infoButton] addTarget:self action:@selector(tableView:) forControlEvents:UIControlEventTouchUpInside];


        }
        
        //[menuItemCell setDelegate:self];
        return menuItemCell;
    }

}


// This method creates new storyboard recursively
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( [_currentCategory isCategories] ) {
        MenuViewController *menuViewController = [[MenuViewController alloc] init];

        MenuCategoryModel *selectedCategory = [_currentCategory.categories objectAtIndex:indexPath.row];
        
        [menuViewController setTitle: selectedCategory.name];
        
        menuViewController->_currentCategory = selectedCategory;
        
        [self.navigationController pushViewController:menuViewController animated:YES];
    }
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    //UITableViewCell *ownerCell = [tableView cellForRowAtIndexPath:indexPath];
    
    MenuItemModel *menuItemModel = [_currentCategory.items objectAtIndex:indexPath.row];
    
    ItemDescription *ItemScreen = [[ItemDescription alloc] init];
    
    //[ItemScreen drawDescriptionWithModel: menuItemModel];
    //[ drawDescriptionWithModel:<#(MenuItemModel *)#>]
    ItemScreen.itemModel = menuItemModel;
    [self.navigationController pushViewController:ItemScreen animated:YES];
}

/*
- (void)delegateForCell:(MenuItemCell *)cell {
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    // do your stuff
    DescriptionScreen *DescriptionUI = [[DescriptionScreen alloc] init];
    //DescriptionScreen *DescriptionUI = [self.storyboard instantiateViewControllerWithIdentifier:@"DescriptionUI"];
    MenuItemModel *menuItemModel = [_currentCategory.items objectAtIndex:indexPath.row];
    
    [DescriptionUI drawDescriptionWithModel: menuItemModel];
   
    [self.navigationController pushViewController:DescriptionUI animated:YES];
}*/

@end
