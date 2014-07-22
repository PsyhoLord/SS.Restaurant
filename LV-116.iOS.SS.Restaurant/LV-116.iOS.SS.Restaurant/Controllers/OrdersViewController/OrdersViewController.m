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

#import "Alert.h"
#import "MapDataProvider.h"
#import "OrdersDataProvider.h"

#import "UserRole.h"
#import "OrderModel.h"
#import "MapModel.h"
#import "TableModel.h"
#import "TableModelWithOrders.h"


static const CGFloat kHeightOfHeaderSection = 35.0f;
static CGFloat kDegreeTransform             = 0.0f;

static NSString *const kSegueToOrderItems  = @"segue_order_items";
static NSString *const kImageOfSectionView = @"arrow_down.png";
static NSString *const kCellIdentifier     = @"CellIdentifier";


@implementation OrdersViewController
{
    NSArray  *_sortedArrayOfString;
    NSMutableArray  *_arrayOfTableModelWithOrders;
    NSMutableArray  *_arrayOfFlags;
}

#pragma mark - Initialization methods

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [SidebarViewController setupSidebarConfigurationForViewController: self
                                                        sidebarButton: self.sidebarButton
                                                            isGesture: YES];
    
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
            dispatch_async( dispatch_get_main_queue(), ^{
                [Alert showConnectionAlert];
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            });
        } else {
            // assigned data from "client" MapModel
            [self createAndSetArray: mapModel];
            
            dispatch_async( dispatch_get_main_queue(), ^{
                
                [self createAndResetFlagsContainer];
                
                [self.tableView reloadData];
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            });
        }
    }];
    
}

// Create and init array with TableModelWithOrders objects.
- (void)createAndSetArray:(MapModel *)mapModel
{
    // if data is then we'll alloc memory for array
    _arrayOfTableModelWithOrders = [[NSMutableArray alloc] init];
    
    for( TableModel *tmpTableModel in mapModel.arrayOfTableModel ){
        TableModelWithOrders *tmpWaiterTable = [[TableModelWithOrders alloc] initWithTableModel: tmpTableModel];
        
        [_arrayOfTableModelWithOrders addObject: tmpWaiterTable];
    }
    
    // Sorts array (at first - free table).
    _sortedArrayOfString = [_arrayOfTableModelWithOrders sortedArrayUsingComparator: ^NSComparisonResult(id obj1, id obj2) {
        BOOL isFree1 = ((TableModelWithOrders*)obj1).isFree;
        BOOL isFree2 = ((TableModelWithOrders*)obj2).isFree;
        
        if( isFree1 < isFree2 ) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        return (NSComparisonResult)NSOrderedAscending;
    }];
    _arrayOfTableModelWithOrders = [_sortedArrayOfString copy];    // Is it the right assigned?
    _sortedArrayOfString = nil;
}

// Create and set initial values for _flagsContainer (if @NO - rows doesn't appear at start; if @YES - rows appear at start).
-(void)createAndResetFlagsContainer
{
    _arrayOfFlags = [[NSMutableArray alloc] init];
    for (int i = 0; i < [_arrayOfTableModelWithOrders count]; ++i) {
        [_arrayOfFlags addObject: @NO];
    }
}

#pragma mark - Loading table orders.

// Loading asynchronously orders on table.
- (void)loadTableOrders:(NSUInteger)section
{
    NSUInteger idOfTableModel = ((TableModelWithOrders*)_arrayOfTableModelWithOrders[section]).Id;
    [OrdersDataProvider loadTableOrdersDataWithTableId: idOfTableModel
                                         responseBlock: ^(NSArray *arrayOfOrderModel, NSError *error) {
        if ( error ) {
            dispatch_async( dispatch_get_main_queue(), ^{
                [Alert showConnectionAlert];
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            });
        } else {
            
            dispatch_async( dispatch_get_main_queue(), ^{

                [((TableModelWithOrders*)_arrayOfTableModelWithOrders[section]) addArrayOfOrders: arrayOfOrderModel];
                
                [self didReceiveOrdersResponse: section];
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            });
        }
        
    }];
}
// It's delete or insert rows for one section.
-(void)didReceiveOrdersResponse:(NSUInteger)section
{
    NSArray *ordersInSection = ((TableModelWithOrders*)_arrayOfTableModelWithOrders[section]).arrayOfOrdersModel;
    
    NSMutableArray *indexPaths = [[NSMutableArray alloc] init]; //    Create index array
    for (int i = 0; i < ordersInSection.count+1; ++i) {
        [indexPaths addObject: [NSIndexPath indexPathForRow:i inSection:section]];
    }
    
    // Get flag of some header section and then make inversion for this header section.
    BOOL isOpen = [[_arrayOfFlags objectAtIndex: section] boolValue];
    [_arrayOfFlags replaceObjectAtIndex: section
                             withObject: [NSNumber numberWithBool: !isOpen] ];
    
    
    if ( isOpen ) {
        ((TableModelWithOrders*)_arrayOfTableModelWithOrders[section]).arrayOfOrdersModel = nil;
        [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
        kDegreeTransform = 0.0;
    } else {
        [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

#pragma mark - Building and init table view components.

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_arrayOfTableModelWithOrders count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kHeightOfHeaderSection;
}

// In this method we return number of row in section when we've clicked.
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfOrders = 0;
    if( _arrayOfFlags ){
        if ( [[_arrayOfFlags objectAtIndex: section ] boolValue] ) {
            // Number of orders + one row for add button
            numberOfOrders = ((TableModelWithOrders*)_arrayOfTableModelWithOrders[section]).arrayOfOrdersModel.count +1;
        }
    }
    return numberOfOrders;
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
    } else {
        NSInteger orderId = ((OrderModel*)((TableModelWithOrders*)_arrayOfTableModelWithOrders[indexPath.section]).arrayOfOrdersModel[indexPath.row]).Id;
        cell.textLabel.text = [NSString stringWithFormat:@"Order %d", orderId];
    }
    
    return cell;
}

// Create view with button for each section.
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, kHeightOfHeaderSection)];
    [sectionView.layer addSublayer: [self createBottomBorder]];     // Adding bottom border.

    UIButton *sectionButton = [self createSectionButton: section];
    [sectionView addSubview: sectionButton];                        // Adding section button.
    
    return sectionView;
}

// Create and setting bottom border.
- (CALayer *)createBottomBorder
{
    // Added bottom border for each sectionView.
    CGFloat colorWithWhite = 0.9f;
    CGFloat alphaColor     = 0.9f;
    
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
    
    NSString *tempStr = [@"Table " stringByAppendingString: ((TableModelWithOrders*)_arrayOfTableModelWithOrders[section]).name];
    
    [sectionButton setTitle: tempStr
                   forState: UIControlStateNormal];
    [sectionButton setTitleColor:[UIColor blackColor]
                        forState:UIControlStateNormal];
    
    [sectionButton addTarget: self
                      action: @selector(didSelectSection:)
            forControlEvents: UIControlEventTouchUpInside];
    
    sectionButton.frame = CGRectMake(0, 0, self.tableView.frame.size.width, kHeightOfHeaderSection);
    
    [sectionButton addSubview: [self createImageViewForSectionButton: section] ];          // Adding imageView on button.
    
    return sectionButton;
}

// Create and setting imageView for UIView.
-(UIImageView*)createImageViewForSectionButton:(NSUInteger)section
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

#pragma mark - Handle user click.

// Handle click on some section header.
- (void)didSelectSection:(UIButton*)sender
{
    if( [_arrayOfFlags[sender.tag] intValue] == 0 ){
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

        NSInteger tableId = ((TableModelWithOrders*)_arrayOfTableModelWithOrders[indexPath.section]).Id;
        
        [OrdersDataProvider postTableOrderOnTableId: tableId responseBlock: ^(NSArray* newOrder, NSError *error) {
            
            if( error ) {
                dispatch_async( dispatch_get_main_queue(), ^{
                    [Alert showHTTPMethodsAlert: error];
                });
            } else {
                dispatch_async( dispatch_get_main_queue(), ^{
                    OrderModel *orderModel = [newOrder objectAtIndex:0];
                    [((TableModelWithOrders*)_arrayOfTableModelWithOrders[indexPath.section]) addOrder: orderModel];
                    [tableView beginUpdates];
                    
                    NSMutableArray *indexPaths = [[NSMutableArray alloc] init]; //    Create index array
                    [indexPaths addObject: [NSIndexPath indexPathForRow: indexPath.row inSection: indexPath.section]];
                    
                    [tableView insertRowsAtIndexPaths:indexPaths  withRowAnimation:UITableViewRowAnimationAutomatic];
                    [tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
                    
                    [tableView endUpdates];
                });
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
        itemsViewController.currentOrder = (OrderModel*)((TableModelWithOrders*)_arrayOfTableModelWithOrders[indexSection]).arrayOfOrdersModel[indexRow];
    }
}

// Handle editing action.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ( editingStyle == UITableViewCellEditingStyleDelete ) {
        [tableView beginUpdates];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        NSUInteger orderId = ((OrderModel*)((TableModelWithOrders*)_arrayOfTableModelWithOrders[indexPath.section]).arrayOfOrdersModel[indexPath.row]).Id;
        [((TableModelWithOrders*)_arrayOfTableModelWithOrders[indexPath.section]) removeOrderAtIndex: indexPath.row];
        
        [OrdersDataProvider deleteTableOrderWithOrderId: orderId
                                          responseBlock: ^(NSError *error) {
                                              if( error ) {
                                                  dispatch_async( dispatch_get_main_queue(), ^{
                                                      [Alert showHTTPMethodsAlert: error];
                                                  });
                                              }
                                          }
         ];
        [tableView endUpdates];
    } else if( editingStyle == UITableViewCellEditingStyleInsert ){
        // Here handle UITableViewCellEditingStyleInsert if we need.
    }
    
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
