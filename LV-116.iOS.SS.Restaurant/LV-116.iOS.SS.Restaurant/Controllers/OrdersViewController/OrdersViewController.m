//
//  OrdersViewController.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Oleg Hnidets on 7/6/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "OrdersViewController.h"
#import "OrderItemsViewController.h"
#import "SidebarViewController+ConfigurationForOtherViewControllers.h"
#import "UIViewController+BackgroundImage.h"

#import "Alert.h"
#import "MapDataProvider.h"
#import "OrdersDataProvider.h"

#import "UserRole.h"
#import "OrderModel.h"
#import "MapModel.h"
#import "TableModel.h"
#import "TableModelWithOrders.h"


static const CGFloat kHeightOfHeaderSection = 40.0f;
static CGFloat kDegreeTransform             = 0.0f;

static NSString *const kSegueToOrderItems  = @"segue_order_items";
static NSString *const kImageOfSectionView = @"arrow_down.png";
static NSString *const kCellIdentifier     = @"CellIdentifier";


@implementation OrdersViewController
{
    NSMutableArray  *_tablesWithOrders;
    NSMutableArray  *_flags;
}

#pragma mark - Initialization methods

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [SidebarViewController setupSidebarConfigurationForViewController: self
                                                        sidebarButton: self.sidebarButton
                                                            isGesture: YES];
 
    [UIViewController setBackgroundImage:self ];
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"blurred2.jpg"]];
    [self loadMapData];
}

#pragma mark - Loading data from remote server
#pragma mark - Loading map data.
// Loading asynchronously map data which based on class MapModel.
- (void)loadMapData
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    [MapDataProvider loadMapDataWithBlock:^(MapModel *mapModel, NSError *error) {
        
        if ( error ) {
            [Alert showConnectionAlert];
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        } else {
            // assigned data from "client" MapModel
            [self createAndSetArray: mapModel];
            
            [self createAndResetFlagsContainer];
            
            [self.tableView reloadData];
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        }
    }];
    
}

// Create and init array with TableModelWithOrders objects.
- (void)createAndSetArray:(MapModel *)mapModel
{
    // if data is then we'll alloc memory for array
    _tablesWithOrders = [[NSMutableArray alloc] init];
    
    for( TableModel *tmpTableModel in mapModel.tables ){
        TableModelWithOrders *tmpWaiterTable = [[TableModelWithOrders alloc] initWithTableModel: tmpTableModel];
        
        [_tablesWithOrders addObject: tmpWaiterTable];
    }
    
    [self sortTables];
}

// Sorts array (at first - free table).
- (void)sortTables
{
    NSArray *_sortedTables;
    _sortedTables = [_tablesWithOrders sortedArrayUsingComparator: ^NSComparisonResult(id obj1, id obj2) {
        BOOL isFree1 = ((TableModelWithOrders*)obj1).isFree;
        BOOL isFree2 = ((TableModelWithOrders*)obj2).isFree;
        
        if( isFree1 < isFree2 ) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        return (NSComparisonResult)NSOrderedAscending;
    }];
    
    _tablesWithOrders = [_sortedTables copy];    // Is it the right assigned?
    _sortedTables = nil;
}

// Create and set initial values for _flagsContainer (if @NO - rows doesn't appear at start; if @YES - rows appear at start).
- (void)createAndResetFlagsContainer
{
    _flags = [[NSMutableArray alloc] init];
    for (int i = 0; i < [_tablesWithOrders count]; ++i) {
        [_flags addObject: @NO];
    }
}

#pragma mark - Loading table orders.

// Loading asynchronously orders on table.
- (void)loadTableOrders:(NSUInteger)section
{
    int idTable = ((TableModelWithOrders*)_tablesWithOrders[section]).Id;
    [OrdersDataProvider loadTableOrdersDataWithTableId: idTable
                                         responseBlock: ^(NSArray *order, NSError *error) {
                                             if ( error ) {
                                                 [Alert showConnectionAlert];
                                                 [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                                                 
                                             } else {
                                                 
                                                 [((TableModelWithOrders*)_tablesWithOrders[section]) addOrders: order];
                                                 
                                                 [self didReceiveOrdersResponse: section];
                                                 [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                                             }
                                             
                                         }];
}
// It's delete or insert rows for one section.
- (void)didReceiveOrdersResponse:(NSUInteger)section
{
    NSArray *ordersInSection = ((TableModelWithOrders*)_tablesWithOrders[section]).orders;
    
    NSMutableArray *indexPaths = [[NSMutableArray alloc] init]; //    Create index array
    for (int i = 0; i < ordersInSection.count+1; ++i) {
        [indexPaths addObject: [NSIndexPath indexPathForRow:i inSection:section]];
    }
    
    // Get flag of some header section and then make inversion for this header section.
    BOOL isOpen = [[_flags objectAtIndex: section] boolValue];
    [_flags replaceObjectAtIndex: section
                      withObject: [NSNumber numberWithBool: !isOpen] ];
    
    
    if ( isOpen ) {
        [((TableModelWithOrders*)_tablesWithOrders[section]) removeAllOrders];
        [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
        kDegreeTransform = 0.0;
    } else {
        [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

#pragma mark - Building and init table view components.

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_tablesWithOrders count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kHeightOfHeaderSection;
}

// In this method we return number of row in section when we've clicked.
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfOrders = 0;
    if( _flags ){
        if ( [[_flags objectAtIndex: section ] boolValue] ) {
            // Number of orders + one row for add button
            numberOfOrders = ((TableModelWithOrders*)_tablesWithOrders[section]).orders.count +1;
        }
    }
    return numberOfOrders;
}

// Create view with button for each section.
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, kHeightOfHeaderSection)];
    [sectionView.layer addSublayer: [self createBottomBorder]];     // Adding bottom border.
    sectionView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:0.1];
    
    UIButton *sectionButton = [self createSectionButton: section];
    [sectionView addSubview: sectionButton];                        // Adding section button.
    
    return sectionView;
}

// Create and setting bottom border.
- (CALayer *)createBottomBorder
{
    // Added bottom border for each sectionView.
    CGFloat colorWithWhite = 0.7f;
    CGFloat alphaColor     = 0.7f;
    
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0, 0, self.tableView.frame.size.width, 1);
    bottomBorder.backgroundColor = [UIColor colorWithWhite: colorWithWhite
                                                     alpha: alphaColor].CGColor;
    return bottomBorder;
}

// Create and add settings for section button
- (UIButton*)createSectionButton:(NSUInteger)section
{
    UIButton *sectionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sectionButton.tag = section;        // We'll use this value when we will have clicked on button.
    
    NSString *tempStr = [@"Table " stringByAppendingString: ((TableModelWithOrders*)_tablesWithOrders[section]).name];
    
    [sectionButton setTitle: tempStr
                   forState: UIControlStateNormal];
    
    sectionButton.titleLabel.font = [UIFont fontWithName:@"AvenirNextCondensed-BoldItalic" size:18];
    sectionButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    sectionButton.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    
    [sectionButton setTitleColor:[UIColor colorWithRed:0.26 green:0.26 blue:0.26 alpha:1.0]
                        forState:UIControlStateNormal];
    
    [sectionButton addTarget: self
                      action: @selector(didSelectSection:)
            forControlEvents: UIControlEventTouchUpInside];
    
    sectionButton.frame = CGRectMake(0, 0, self.tableView.frame.size.width, kHeightOfHeaderSection);
    
    [sectionButton addSubview: [self createImageViewForSectionButton: section] ];          // Adding imageView on button.
    
    return sectionButton;
}

// Create and setting imageView for UIView.
- (UIImageView*)createImageViewForSectionButton:(NSUInteger)section
{
    UIImage *image = [UIImage imageNamed: kImageOfSectionView];
    UIImageView *imageView = [[UIImageView alloc] initWithImage: image];
    
    // Set coordinates and width, height of imageView (our image).
    NSUInteger xImage      = self.tableView.frame.size.width - 40;
    NSUInteger yImage      = 5;
    NSUInteger widthImage  = kHeightOfHeaderSection / 1.5;
    NSUInteger heightImage = kHeightOfHeaderSection / 1.5;
    
    imageView.frame = CGRectMake(xImage, yImage, widthImage, heightImage);
    
    return imageView;
}

// Create cells for header section.
- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: kCellIdentifier];
    if ( cell == nil ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier];
    }
    
    if( indexPath.row == [tableView numberOfRowsInSection: indexPath.section]-1 ) {
        cell.textLabel.text = @"New order";
        cell.textLabel.font = [UIFont fontWithName:@"AvenirNextCondensed-Italic" size:17];
        cell.textLabel.textAlignment = NSTextAlignmentRight;
        cell.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:0.3];
    } else {
        NSInteger orderId = ((OrderModel*)((TableModelWithOrders*)_tablesWithOrders[indexPath.section]).orders[indexPath.row]).Id;
        cell.textLabel.text = [NSString stringWithFormat:@"Order %ld", (long)orderId];
        cell.textLabel.font = [UIFont fontWithName:@"System" size:18];
        cell.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:0.4];
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    return cell;
}

#pragma mark - Handle user click.

// Handle click on some section header.
- (void)didSelectSection:(UIButton*)sender
{
    if( [_flags[sender.tag] intValue] == 0 ){
        [self loadTableOrders: sender.tag];
        kDegreeTransform = M_PI_2*2;
    } else {
        [self didReceiveOrdersResponse: sender.tag];
        kDegreeTransform = 0;
    }
    // check on UIImageView.
    for ( id tmpImagView in sender.subviews ){
        if ( [tmpImagView isMemberOfClass: [UIImageView class]] ){
            ((UIImageView*)tmpImagView).transform = CGAffineTransformMakeRotation( kDegreeTransform );
        }
    }
}

// Handle click on cell of add (the last cell).
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( indexPath.row == [tableView numberOfRowsInSection: indexPath.section]-1 ) {
        
        // Create new empty order and push it in array.
        
        int tableId = ((TableModelWithOrders*)_tablesWithOrders[indexPath.section]).Id;
        
        [OrdersDataProvider createTableOrderOnTableId: tableId responseBlock: ^(NSArray* newOrder, NSError *error) {
            
            if( error ) {
                [Alert showHTTPMethodsAlert: error];
            } else {
                OrderModel *orderModel = [newOrder objectAtIndex:0];
                [((TableModelWithOrders*)_tablesWithOrders[indexPath.section]) addOrder: orderModel];
                [tableView beginUpdates];
                
                NSMutableArray *indexPaths = [[NSMutableArray alloc] init]; //    Create index array
                [indexPaths addObject: [NSIndexPath indexPathForRow: indexPath.row inSection: indexPath.section]];
                
                [tableView insertRowsAtIndexPaths:indexPaths  withRowAnimation:UITableViewRowAnimationAutomatic];
                [tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
                
                [tableView endUpdates];
            }
        }
         ];
    } else {
        [self performSegueWithIdentifier: kSegueToOrderItems
                                  sender: [tableView cellForRowAtIndexPath: indexPath]];
    }
}

- (void) prepareForSegue: (UIStoryboardSegue*)segue sender: (id)sender
{
    if( [segue.identifier isEqualToString: kSegueToOrderItems ] ){
        NSUInteger indexSection = [self.tableView indexPathForCell: sender].section;
        NSUInteger indexRow     = [self.tableView indexPathForCell: sender].row;
        
        OrderItemsViewController *itemsViewController = (OrderItemsViewController*)segue.destinationViewController;
        itemsViewController.currentOrder = (OrderModel*)((TableModelWithOrders*)_tablesWithOrders[indexSection]).orders[indexRow];
    }
}

// Handle editing action.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( editingStyle == UITableViewCellEditingStyleDelete ) {
        [tableView beginUpdates];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        int orderId = ((OrderModel*)((TableModelWithOrders*)_tablesWithOrders[indexPath.section]).orders[indexPath.row]).Id;
        [((TableModelWithOrders*)_tablesWithOrders[indexPath.section]) removeOrderAtIndex: indexPath.row];
        
        [OrdersDataProvider deleteTableOrderWithOrderId: orderId
                                          responseBlock: ^(NSError *error) {
                                              if( error ) {
                                                  [Alert showHTTPMethodsAlert: error];
                                              }
                                          }
         ];
        [tableView endUpdates];
    } else if( editingStyle == UITableViewCellEditingStyleInsert ){
        // Here handle UITableViewCellEditingStyleInsert if we need.
    }
    
}

// Return NO if you do not want the specified item to be editable.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

// Set editing style for cell. The last cell has not any editing style.
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( indexPath.row != [tableView numberOfRowsInSection: indexPath.section]-1 ) {
        return UITableViewCellEditingStyleDelete;
    } else {
        return UITableViewCellEditingStyleNone;
    }
}

@end
