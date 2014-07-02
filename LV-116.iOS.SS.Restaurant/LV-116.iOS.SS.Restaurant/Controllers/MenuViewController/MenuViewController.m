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
#import "DataProvider.h"
#import "MenuModel.h"
#import "MenuCategoryModel.h"
#import "MenuItemModel.h"
#import "Alert.h"
#import "DescriptionScreen.h"
#import "UIItemDescription.h"
#import "ItemDescription.h"

static NSString *const menuCategoryCellIdentifier   = @"menuCategoryCellIdentifier";
static NSString *const menuItemCellIdentifier       = @"menuItemCellIdentifier";
static const NSUInteger numberOfSectionsInTableView = 1;



#warning What about using self.tableView ? UITableViewController provides you built in "tableView" property

@implementation MenuViewController
{
    MenuCategoryModel *_currentCategory;
}

#warning use blocks instead of Notifications !!!

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ( _currentCategory == nil ) {
        [self loadMenuData];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView // Кількість секцій в TableView
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

#warning Boolean flag usage leads to complex BUGS ! Try to avoid it !!!
#warning you can extract method here. Something like "showCategoryItems" or "navigateToCategoryItems"

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

#warning COMMENT YOUR CODE ONLY IN ENGLISH !!!!!!
#warning It's not a good practice to use "nil" for some logic. At least you can encapsulate it in some method inside the DataProvider. Just add another method called "getAllMenu" and place [self getMenuData:nil] as a body of this method. It's your internal logic, so stay as more simple as you can for component which will use your DataProvider.

// This method loads menu data from remote
- (void)loadMenuData
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    [DataProvider loadMenuDataWithBlock:^(MenuModel *menuModel, NSError *error) {
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        if ( error ) {
            [Alert showConnectionAlert];
        } else {
            
         _currentCategory = menuModel.rootMenuCategory;
        
        [self.tableView reloadData];
        
        }
    }];
    
}

#warning Try to move view events at the begginng of ViewController implementation. Also, make sure al events are placed in right order. For example: viewDidLoad goes before viewDidAppear
#warning I decided to skip this method because it looks incomplete. Right ? :)

#warning DON'T COMMIT WORDS LIKE "X3" !!!!!

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    //UITableViewCell *ownerCell = [tableView cellForRowAtIndexPath:indexPath];
    
    MenuItemModel *menuItemModel = [_currentCategory.items objectAtIndex:indexPath.row];
    
    ItemDescription *ItemScreen = [[ItemDescription alloc] initWithModel:menuItemModel];
    
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
