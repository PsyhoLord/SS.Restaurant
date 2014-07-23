//
//  SidebarViewController.m
//  SidebarDemo
//
//  Created by Simon on 29/6/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "SidebarViewController.h"
#import "SWRevealViewController.h"
#import "UITableView+TableView_Image.h"

#import "HomeViewController.h"
#import "MenuViewController.h"
#import "MapViewController.h"
#import "OrdersViewController.h"

#import "SidebarTableViewCell.h"

#import "MapDataProvider.h"

#import "MapModel.h"
#import "TableModel.h"

#import "Alert.h"
#import "UserRole.h"

// number of sections in table view
static const NSUInteger kNumberOfSections        = 1;

// number of cells needs for waiter in the end of table view
static const NSUInteger kNumberOfCellsForClient  = 4;
// !!! this is only for test without any authorization !!!
//static const NSUInteger kNumberOfCellsForClient  = 4;
static const NSUInteger kNumberOfCellsForWaiter  = 5;

static NSString *const  kSidebarTableViewCellIdentifier = @"SidebarTableViewCellIdentifier";

// consts segue to another scrins
static NSString *const kSegueToHome     = @"sw_segue_home";
static NSString *const kSegueToMenu     = @"sw_segue_menu";
static NSString *const kSegueToMap      = @"sw_segue_map";
static NSString *const kSegueToLocation = @"sw_segue_location";
static NSString *const kSegueToOrders   = @"sw_segue_orders";

// const strings of images for cells
static NSString *const kCellImageHome     = @"home_icon.png";
static NSString *const kCellImageMenu     = @"menu_icon.png";
static NSString *const kCellImageMap      = @"map_icon.png";
static NSString *const kCellImageLocation = @"location_icon2.png";
static NSString *const kCellImageOrders   = @"waiter.png";

// const strings of labels for cells
static NSString *const kCellLabelTextHome     = @"Home";
static NSString *const kCellLabelTextMenu     = @"Menu";
static NSString *const kCellLabelTextMap      = @"Map";
static NSString *const kCellLabelTextLocation = @"Location";
static NSString *const kCellLabelTextOrders   = @"Orders";

// const strings of titles for destination view controllers
static NSString *const kDestinationViewControllerTitleHome      = @"Home";
static NSString *const kDestinationViewControllerTitleMenu      = @"Menu";
static NSString *const kDestinationViewControllerTitleMap       = @"Map";
static NSString *const kDestinationViewControllerTitleLocation  = @"Location";
static NSString *const kDestinationViewControllerTitleOrders    = @"Orders";

static const CGFloat kRearViewRevealWidth = 175.0f;

// enum of all cells on root sidebar menu
typedef enum
{
    CellHomePage,
    CellMenuPage,
    CellMapPage,
    CellLocationPage,
    CellOrdersPage
} EnumCellForPage;

@implementation SidebarViewController

#pragma mark - initialization methods

- (void) viewDidLoad
{
    [super viewDidLoad];
    [UIViewController setBackgroundImage:self];
    self.revealViewController.rearViewRevealWidth = kRearViewRevealWidth;
}

// reload data of sidebar menu on main thread
- (void) reloadData
{
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger) numberOfSectionsInTableView: (UITableView *)tableView
{
    return kNumberOfSections;
}

- (NSInteger) tableView: (UITableView *)tableView numberOfRowsInSection: (NSInteger)section
{
    // Return the number of rows in the section.
    EnumUserRole enumUserRole = ([UserRole getInstance]).enumUserRole;
    switch ( enumUserRole ) {
        case UserRoleClient:
            return kNumberOfCellsForClient; // without cell - orders
        case UserRoleWaiter:
            return kNumberOfCellsForWaiter;
    }
}

//Method for row height setting (for items and for category)
- (CGFloat) tableView: (UITableView *)tableView heightForRowAtIndexPath: (NSIndexPath *)indexPath
{
    return [SidebarTableViewCell rowHeightForCell];
}

- (UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath: (NSIndexPath *)indexPath
{
    SidebarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: kSidebarTableViewCellIdentifier];
    
    [cell drawWithImage: [self getImageForCellAtIndexPath: indexPath]
                   text: [self getTextForCellAtIndexPath: indexPath]];
    cell.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.0];
    return cell;
}

// return image for appropriate cell according to indexPath
- (UIImage*) getImageForCellAtIndexPath: (NSIndexPath*)indexPath
{
    UIImage *image;
    
    EnumCellForPage enumCell = indexPath.row;
    switch ( enumCell ) {
        case CellHomePage:
            image = [UIImage imageNamed: kCellImageHome];
            break;
        case CellMenuPage:
            image = [UIImage imageNamed: kCellImageMenu];
            break;
        case CellMapPage:
            image = [UIImage imageNamed: kCellImageMap];
            break;
        case CellLocationPage:
            image = [UIImage imageNamed: kCellImageLocation];
            break;
        case CellOrdersPage:
            image = [UIImage imageNamed: kCellImageOrders];
            break;
    }
    
    return image;
}

// return string for appropriate cell according to indexPath
- (NSString*) getTextForCellAtIndexPath: (NSIndexPath*)indexPath
{
    NSString *text;
    
    EnumCellForPage enumCell = indexPath.row;
    switch ( enumCell ) {
        case CellHomePage:
            text = kCellLabelTextHome;
            break;
        case CellMenuPage:
            text = kCellLabelTextMenu;
            break;
        case CellMapPage:
            text = kCellLabelTextMap;
            break;
        case CellLocationPage:
            text = kCellLabelTextLocation;
            break;
        case CellOrdersPage:
            text = kCellLabelTextOrders;
            break;
    }
    
    return text;
}

#pragma mark - Segue on next screen

// This method performs sqgue to appropriate scrin
- (void) tableView: (UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath*)indexPath
{
    NSString *stringSegue = [self getStringSegueForRowAtIndexPath: indexPath];
    [self performSegueWithIdentifier: stringSegue sender: self];
}

// return string of appropriate segue according ro indexPath
- (NSString*) getStringSegueForRowAtIndexPath: (NSIndexPath*)indexPath
{
    NSString *stringSegue;
    EnumCellForPage enumCell = indexPath.row;
    switch ( enumCell ) {
        case CellHomePage:
            stringSegue = kSegueToHome;
            break;
        case CellMenuPage:
            stringSegue = kSegueToMenu;
            break;
        case CellMapPage:
            stringSegue = kSegueToMap;
            break;
        case CellLocationPage:
            stringSegue = kSegueToLocation;
            break;
        case CellOrdersPage:
            stringSegue = kSegueToOrders;
            break;
    }
    return stringSegue;
}

// something that did before segue
- (void) prepareForSegue: (UIStoryboardSegue*)segue sender: (id)sender
{
    UIViewController *destinationViewController = segue.destinationViewController;
    destinationViewController.title = [self getTitleForDestinationViewController: destinationViewController];
    
    if ( [destinationViewController isKindOfClass: [MenuViewController class]] ) {
        ((MenuViewController*)destinationViewController).isGestureForCallSidebar = YES;
    }
    
    if ( [segue isKindOfClass: [SWRevealViewControllerSegue class]] ) {
        
        SWRevealViewControllerSegue *swSegue = (SWRevealViewControllerSegue*) segue;
        
        swSegue.performBlock = ^(SWRevealViewControllerSegue* rvc_segue, UIViewController* svc, UIViewController* dvc) {
            
            UINavigationController* navController = (UINavigationController*)self.revealViewController.frontViewController;
            [navController setViewControllers: @[dvc] animated: NO];
            [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
            
        };
        
    }
}

// return string of title for appropriate destination view controller
// (UIViewController*)destinationViewController - destination view controller on segue
- (NSString*) getTitleForDestinationViewController: (UIViewController*)destinationViewController
{
    NSString *title;
    
    if ( [destinationViewController isKindOfClass: [HomeViewController class]] ) {
        title = kDestinationViewControllerTitleHome;
    } else if ( [destinationViewController isKindOfClass: [MenuViewController class]] ) {
        title = kDestinationViewControllerTitleMenu;
    } else if ( [destinationViewController isKindOfClass: [MapViewController class]] ) {
        title = kDestinationViewControllerTitleMap;
    } else if ( [destinationViewController isKindOfClass: [OrdersViewController class]] ) {
        title = kDestinationViewControllerTitleOrders;
    }
    
    return title;
}

@end
