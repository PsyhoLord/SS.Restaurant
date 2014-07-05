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
#import "MapDataProvider.h"
#import "WaiterMapModel.h"
#import "WaiterTableModel.h"
#import "MapModel.h"
#import "TableModel.h"
#import "Alert.h"

static NSString *const  kSegueToOrdersView   = @"sw_orders";
static NSString *const  kTableCellIdentifier = @"TableCellIdentifier";
static const NSUInteger kNumberOfSections    = 1;
static NSString *const  kTableNameFormat     = @"Table # ";

@implementation SidebarViewController

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
    
    [self loadMapData];
}

- (void) loadMapData
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    [MapDataProvider loadMapDataWithBlock:^(MapModel *mapModel, NSError *error) {
        if ( error ) {
            dispatch_async( dispatch_get_main_queue(), ^{
                [Alert showConnectionAlert];
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            });
        } else {
            _waiterMapModel = [[WaiterMapModel alloc] initWithMapModel:mapModel];
            dispatch_async( dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            });
        }
    }];
    
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return kNumberOfSections;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_waiterMapModel.arrayOfTableModel count];
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableCellIdentifier];
    if ( cell == nil ) {
        cell = [[UITableViewCell alloc] init];
    }
    cell.textLabel.text = [kTableNameFormat stringByAppendingString:((WaiterTableModel*)_waiterMapModel.arrayOfTableModel[indexPath.row]).table.name];
    return cell;
}

#pragma mark - Segue on next screen

- (void) tableView: (UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    [self performSegueWithIdentifier:kSegueToOrdersView sender:self];
}

// something that did before segue
- (void) prepareForSegue: (UIStoryboardSegue *)segue sender: (id)sender
{
    // Set the title of navigation bar by using the menu items
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    UINavigationController *destViewController = (UINavigationController*)segue.destinationViewController;
    
    if ( [segue.identifier isEqualToString:kSegueToOrdersView] ) {
        // set data to destViewController
        ((OrdersViewController*)destViewController).currentWaiterTable = [_waiterMapModel.arrayOfTableModel objectAtIndex:indexPath.row];
        
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


@end
