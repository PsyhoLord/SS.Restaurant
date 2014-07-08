//
//  SidebarViewController.m
//  SidebarDemo
//
//  Created by Simon on 29/6/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "SidebarViewController.h"
#import "SWRevealViewController.h"
#import "OrdersViewController.h"
#import "SidebarTableViewCell.h"

#import "MapDataProvider.h"

#import "WaiterMapModel.h"
#import "WaiterTableModel.h"
#import "MapModel.h"
#import "TableModel.h"

#import "Alert.h"
#import "UserRole.h"

static const NSUInteger kNumberOfSections                   = 1;
static NSString *const  kTitleTableViewCellIdentifier       = @"TitleCellIdentifier";
static NSString *const  kMenuTableViewCellIdentifier        = @"MenuCellIdentifier";
static NSString *const  kMapTableViewCellIdentifier         = @"MapCellIdentifier";
static NSString *const  kOrdersTableViewCellIdentifier      = @"OrdersCellIdentifier";

typedef enum
{
    CellHomePage,
    CellMenuPage,
    CellMapPage,
    CellOrdersPage
} EnumCellForPage;

@implementation SidebarViewController
{
    NSArray *_rootMenuItems;
}

- (id) initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    self.revealViewController.rearViewRevealWidth = 175.0f;
    
    _rootMenuItems = @[kTitleTableViewCellIdentifier, kMenuTableViewCellIdentifier, kMapTableViewCellIdentifier, kOrdersTableViewCellIdentifier];
}

- (void) reloadData
{
    dispatch_async( dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return kNumberOfSections;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    switch ( [UserRole getUserRole] ) {
        case UserRoleClient:
            return [_rootMenuItems count] - 1; // without cell - orders
        case UserRoleWaiter:
            return [_rootMenuItems count];
    }
}

//Method for row height setting (for items and for category)
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [SidebarTableViewCell rowHeightForCell];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = _rootMenuItems[indexPath.row];
    
    SidebarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        cell = [[SidebarTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                           reuseIdentifier:cellIdentifier];
        [cell drawWithImage: [self getImageForCellAtIndexPath:indexPath]
                       text: [self getTextForCellAtIndexPath:indexPath]];
    }
    return cell;
}

- (UIImage*) getImageForCellAtIndexPath:(NSIndexPath*)indexPath
{
    UIImage *image;
    
    EnumCellForPage enumCell = indexPath.row;
    switch ( enumCell ) {
        case CellHomePage:
            image = [UIImage imageNamed:@"home_page_icon.png"];
            break;
        case CellMenuPage:
            image = [UIImage imageNamed:@"menu_icon.png"];
            break;
        case CellMapPage:
            image = [UIImage imageNamed:@"map_icon.png"];
            break;
        case CellOrdersPage:
            image = [UIImage imageNamed:@"orders_icon.png"];
            break;
    }
    
    return image;
}

- (NSString*) getTextForCellAtIndexPath:(NSIndexPath*)indexPath
{
    NSString *text;
    
    EnumCellForPage enumCell = indexPath.row;
    switch ( enumCell ) {
        case CellHomePage:
            text = @"Home";
            break;
        case CellMenuPage:
            text = @"Menu";
            break;
        case CellMapPage:
            text = @"Map";
            break;
        case CellOrdersPage:
            text = @"Orders";
            break;
    }
    
    return text;
}

#pragma mark - Segue on next screen

// This method creates new storyboard recursively
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    NSString *stringSegue = [self getStringSegueForRowAtIndexPath:indexPath];
    [self performSegueWithIdentifier:stringSegue sender:self];
}

- (NSString*) getStringSegueForRowAtIndexPath:(NSIndexPath*)indexPath
{
    NSString *stringSegue;
    EnumCellForPage enumCell = indexPath.row;
    switch ( enumCell ) {
        case CellHomePage:
            stringSegue = @"sw_segue_home";
            break;
        case CellMenuPage:
            stringSegue = @"sw_segue_menu";
            break;
        case CellMapPage:
            stringSegue = @"sw_segue_map";
            break;
        case CellOrdersPage:
            stringSegue = @"sw_segue_orders";
            break;
    }
    return stringSegue;
}

// something that did before segue
- (void) prepareForSegue: (UIStoryboardSegue*)segue sender: (id)sender
{
    if ( [segue isKindOfClass: [SWRevealViewControllerSegue class]] ) {
        
        SWRevealViewControllerSegue *swSegue = (SWRevealViewControllerSegue*) segue;
        
        swSegue.performBlock = ^(SWRevealViewControllerSegue* rvc_segue, UIViewController* svc, UIViewController* dvc) {
            
            UINavigationController* navController = (UINavigationController*)self.revealViewController.frontViewController;
            [navController setViewControllers: @[dvc] animated: NO];
            [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
            
        };
        
    }
}

@end
