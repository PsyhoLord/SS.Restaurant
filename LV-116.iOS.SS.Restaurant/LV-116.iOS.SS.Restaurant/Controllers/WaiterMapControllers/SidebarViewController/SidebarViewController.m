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

static const NSUInteger kNumberOfSections                   = 1;
static NSString *const  kTitleTableViewCellIdentifier       = @"TitleCellIdentifier";
static NSString *const  kMenuTableViewCellIdentifier        = @"MenuCellIdentifier";
static NSString *const  kMapTableViewCellIdentifier         = @"MapCellIdentifier";
static NSString *const  kMapWaiterTableViewCellIdentifier   = @"MapWaiterCellIdentifier";

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
    
    _rootMenuItems = @[kTitleTableViewCellIdentifier, kMenuTableViewCellIdentifier, kMapTableViewCellIdentifier, kMapWaiterTableViewCellIdentifier];
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
    return [_rootMenuItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = _rootMenuItems[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    return cell;
}

#pragma mark - Segue on next screen

// something that did before segue
- (void) prepareForSegue: (UIStoryboardSegue *)segue sender: (id)sender
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
