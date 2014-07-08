//
//  TestDropTableView.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Oleg Hnidets on 7/6/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "OrdersViewController.h"
#import "SWRevealViewController.h"
#import "OrderItemsViewController.h"

#import "MapDataProvider.h"
#import "Alert.h"

#import "WaiterMapModel.h"
#import "WaiterTableModel.h"

#import "OrderModel.h"
#import "MapModel.h"
#import "TableModel.h"

static NSString *const kOrdersTitle            = @"Orders";
static const CGFloat kHeightOfHeaderSection    = 35.0f;


@implementation OrdersViewController
{
    NSDictionary *_currentSection;
    NSMutableArray *_flagsContainer;
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
    
    self.title = kOrdersTitle;
    
    [self setSidebarConfiguration];
    
    [self loadMapData];
}

- (void)setSidebarConfiguration
{
    // Change button color
    _sidebarButton.tintColor = [UIColor colorWithWhite:0.1f alpha:0.9f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
}

// Load asynchronously map data which based on class MapModel
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
            // assigned data from "client" MapModel
            _waiterMapModel = [[WaiterMapModel alloc] initWithMapModel: mapModel];
            dispatch_async( dispatch_get_main_queue(), ^{
                
                [self createAndResetFlagsContainer];
                
                [self.tableView reloadData];
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            });
            
            
        }
    }];
    
}

// Create and set initial values for _flagsContainer (if @NO - rows doesn't appear at start; if @YES - rows appear at start).
-(void)createAndResetFlagsContainer
{
    _flagsContainer = [[NSMutableArray alloc] init];
    for (int i=0; i < [_waiterMapModel.arrayOfTableModel count]; ++i) {
        [_flagsContainer addObject: @NO];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kHeightOfHeaderSection;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_waiterMapModel.arrayOfTableModel count];
}

// In this method we return number of row in section when we've clicked.
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfOrders = 0;
    if( _flagsContainer ){
        if ( [[_flagsContainer objectAtIndex: section ] boolValue] ) {
            // Number of orders + one row for add button
            numberOfOrders = ((WaiterTableModel*)_waiterMapModel.arrayOfTableModel[section]).arrayOfOrders.count +1;
        }
    }
    return numberOfOrders;
}

// Create button for each section.
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionView = [[UIView alloc] init];
    UIButton *sectionButton = [self createSectionButton: section];
    
    [sectionView addSubview: sectionButton];
    
    return sectionButton;  //  if you need - return sectionView
}

// Create and set settings for section button
- (UIButton*)createSectionButton:(NSInteger)section
{
    UIButton *sectionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sectionButton.tag = section;
    
    NSString *tempStr = [@"Table #" stringByAppendingString:((WaiterTableModel*)_waiterMapModel.arrayOfTableModel[section]).table.name];
    
    [sectionButton setTitle: tempStr
                   forState: UIControlStateNormal];
    [sectionButton setTitleColor:[UIColor blackColor]
                        forState:UIControlStateNormal];
    
    [sectionButton addTarget: self
                      action: @selector(didSelectSection:)
            forControlEvents: UIControlEventTouchUpInside];
    
    sectionButton.frame = CGRectMake(0, 0, 130, 30);
    
    return sectionButton;
}

// Handle click on some header of section.
- (void)didSelectSection:(UIButton*)sender {
    
    NSArray *items = ((WaiterTableModel*)_waiterMapModel.arrayOfTableModel[sender.tag]).arrayOfOrders;  //    Get order from table
    
    NSMutableArray *indexPaths = [NSMutableArray array]; //    Create index array
    for (int i=0; i < items.count+1; ++i) {
        [indexPaths addObject: [NSIndexPath indexPathForRow:i inSection:sender.tag]];
    }
    
    //    Get flag of some header section and then make inversion for this header section
    BOOL isOpen = [[_flagsContainer objectAtIndex: sender.tag] boolValue];
    [_flagsContainer replaceObjectAtIndex: sender.tag
                               withObject: [NSNumber numberWithBool: !isOpen] ];
    
    if ( isOpen ) {
        [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
    } else {
        [self.tableView insertRowsAtIndexPaths:indexPaths  withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

// Create cell for header section
- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];
    if ( cell == nil ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellIdentifier"];
    }
    
    if( indexPath.row == [tableView numberOfRowsInSection: indexPath.section]-1 ) {
        cell.textLabel.text = @"Add";
    } else {
        cell.textLabel.text = [NSString stringWithFormat:@"Order #%d", indexPath.row];
    }
    
    return cell;
}

// Handle click on add cell (the last cell).
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( indexPath.row == [tableView numberOfRowsInSection: indexPath.section]-1 ) {
        
        OrderModel *orderModel = [[OrderModel alloc] init];
        [((WaiterTableModel*)_waiterMapModel.arrayOfTableModel[indexPath.section]) addOrder:orderModel];
        
        //        if( ((WaiterTableModel*)_waiterMapModel.arrayOfTableModel[indexPath.section]).arrayOfOrders == nil ){
        //            ((WaiterTableModel*)_waiterMapModel.arrayOfTableModel[indexPath.section]).arrayOfOrders = [[NSMutableArray alloc] init];
        //        }
        //        NSString *str = [[NSString alloc] initWithFormat:@"Order%ld", random()];
        
        [self.tableView reloadData];
    } else {
        OrderItemsViewController *orderItemsViewController = [[OrderItemsViewController alloc] init];
        [self.navigationController pushViewController: orderItemsViewController
                                             animated: YES];
//        [self.navigationController performSegueWithIdentifier: kSegueForOrderItems sender:self];
    }
}

// Set editing style for cell. Add cell has not any editing style.
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( indexPath.row != [tableView numberOfRowsInSection: indexPath.section]-1 ) {
        return UITableViewCellEditingStyleDelete;
    } else {
        return UITableViewCellEditingStyleNone;
    }
}

// Handle editing action.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView beginUpdates];
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [((WaiterTableModel*)_waiterMapModel.arrayOfTableModel[indexPath.section]).arrayOfOrders removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    } else if(editingStyle == UITableViewCellEditingStyleInsert){
        // Here handle UITableViewCellEditingStyleInsert if we need.
    }
    [tableView endUpdates];
}

@end
