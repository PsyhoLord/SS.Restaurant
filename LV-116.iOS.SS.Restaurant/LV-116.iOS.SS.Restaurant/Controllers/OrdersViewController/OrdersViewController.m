//
//  OrdersViewController.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Oleg Hnidets on 7/6/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "OrdersViewController.h"

#import "SidebarViewController+ConfigurationForOtherViewControllers.h"

#import "OrderItemsViewController.h"

#import "MapDataProvider.h"
#import "OrdersDataProvider.h"
#import "Alert.h"

#import "OrderModel.h"
#import "MapModel.h"
#import "TableModel.h"
#import "TableModelWithOrders.h"

static const CGFloat kHeightOfHeaderSection    = 35.0f;

static NSString *const kSegueToOrderItems      = @"segue_order_items";
static NSString *const kImageOfSectionView     = @"arrow_down.png";

@implementation OrdersViewController
{
    NSArray  *_sortedArrayOfString;
    NSMutableArray  *_arrayOfTableModelWithOrders;
    NSMutableArray  *_arrayOfFlags;
}

#pragma mark - Initialization methods

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
    
    [SidebarViewController setupSidebarConfigurationForViewController: self
                                                        sidebarButton: self.sidebarButton
                                                            isGesture: YES];
    
//    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
    [self loadMapData];
}

#pragma mark - Load data from remote server

// Load asynchronously map data which based on class MapModel
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
    
    _sortedArrayOfString = [_arrayOfTableModelWithOrders sortedArrayUsingComparator: ^NSComparisonResult(id obj1, id obj2) {
        BOOL isFree1 = ((TableModelWithOrders*)obj1).isFree;
        BOOL isFree2 = ((TableModelWithOrders*)obj2).isFree;
        
        if( isFree1 < isFree2 ) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        return (NSComparisonResult)NSOrderedAscending;
    }];
    _arrayOfTableModelWithOrders = [_sortedArrayOfString copy];    // Is it the right assigned?
}
// Create and set initial values for _flagsContainer (if @NO - rows doesn't appear at start; if @YES - rows appear at start).
-(void)createAndResetFlagsContainer
{
    _arrayOfFlags = [[NSMutableArray alloc] init];
    for (int i=0; i < [_arrayOfTableModelWithOrders count]; ++i) {
        [_arrayOfFlags addObject: @NO];
    }
}

// Load asynchronously orders on table.
- (void)loadTableOrders:(UIButton *)sender
{
    NSUInteger idOfTableModel = ((TableModelWithOrders*)_arrayOfTableModelWithOrders[sender.tag]).Id;
    [OrdersDataProvider loadTableOrdersDataWithTableId: idOfTableModel
                                         responseBlock: ^(NSArray *arrayOfOrderModel, NSError *error) {
        if ( error ) {
            dispatch_async( dispatch_get_main_queue(), ^{
                [Alert showConnectionAlert];
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            });
        } else {
            
            dispatch_async( dispatch_get_main_queue(), ^{

                [((TableModelWithOrders*)_arrayOfTableModelWithOrders[sender.tag]) addArrayOfOrders: arrayOfOrderModel];
                
                [self didReceiveOrdersResponse: sender];
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            });
        }
        
    }];
}
// It's delete or insert rows for one section.
-(void)didReceiveOrdersResponse:(UIButton*)sender
{
    NSArray *items = ((TableModelWithOrders*)_arrayOfTableModelWithOrders[sender.tag]).arrayOfOrdersModel;
    
    NSMutableArray *indexPaths = [[NSMutableArray alloc] init]; //    Create index array
    for (int i=0; i < items.count+1; ++i) {
        [indexPaths addObject: [NSIndexPath indexPathForRow:i inSection:sender.tag]];
    }
    
    //    Get flag of some header section and then make inversion for this header section
    BOOL isOpen = [[_arrayOfFlags objectAtIndex: sender.tag] boolValue];
    [_arrayOfFlags replaceObjectAtIndex: sender.tag
                             withObject: [NSNumber numberWithBool: !isOpen] ];
    
    
    if ( isOpen ) {
        ((TableModelWithOrders*)_arrayOfTableModelWithOrders[sender.tag]).arrayOfOrdersModel = nil;
        
        [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
    } else {
        
        [self.tableView insertRowsAtIndexPaths:indexPaths  withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

#pragma mark - Building and init table view components.

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kHeightOfHeaderSection;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_arrayOfTableModelWithOrders count];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];
    if ( cell == nil ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellIdentifier"];
    }
    
    if( indexPath.row == [tableView numberOfRowsInSection: indexPath.section]-1 ) {
        cell.textLabel.text = @"Add";
    } else {
        cell.textLabel.text = [NSString stringWithFormat:@"Order %d", indexPath.row];
    }
    
    return cell;
}

// Create button for each section.
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, kHeightOfHeaderSection)];
    UIButton *sectionButton = [self createSectionButton: section];
    
    
    // Adding subviews and layer in UIView.
    [sectionView.layer addSublayer: [self createBottomBorder]];            // Adding bottom border.

    [sectionView addSubview: sectionButton];                               // Adding section buttonMaybe make sense [sectionView addSubview: [self createSectionButton: section]]; I don't know.
    
    
    return sectionView;  //  if you need - return sectionView
}
// Create and setting bottom border.
- (CALayer *)createBottomBorder
{
    // Added bottom border for each sectionView.
    CGFloat colorWithWhite = 0.8f;
    CGFloat alphaColor     = 1.0f;
    
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0, 0, self.tableView.frame.size.width, 1);
    bottomBorder.backgroundColor = [UIColor colorWithWhite: colorWithWhite
                                                     alpha: alphaColor].CGColor;
    return bottomBorder;
}
// Create and set settings for section button
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
    
    [sectionButton addSubview: [self createImageView: section] ];          // Adding imageView on button.
    
    return sectionButton;
}
// Create and setting imageView for UIView.
-(UIImageView*)createImageView:(NSUInteger)section
{
    UIImage *image = [UIImage imageNamed: kImageOfSectionView];
    UIImageView *imageView = [[UIImageView alloc] initWithImage: image];
    
    // Set coordinates and width, height of imageView (our image).
    NSUInteger xImage      = self.tableView.frame.size.width - 40;
    NSUInteger yImage      = 5;
    NSUInteger widthImage  = 23;
    NSUInteger heightImage = 23;
    
    imageView.frame = CGRectMake(xImage, yImage, widthImage, heightImage);
    
    
    return imageView;
}


#pragma mark - Handle user click.


// Handle click on some section header.
- (void)didSelectSection:(UIButton*)sender
{
    CGFloat degreeTransform = 0.0;
    
    if( [_arrayOfFlags[sender.tag] intValue] == 0 ){
        [self loadTableOrders:sender];
        degreeTransform = M_PI_2*2;
    } else {
        [self didReceiveOrdersResponse: sender];
        degreeTransform = 0.0; // or some other
    }
    // subviews[1] keeps UIImageView.
    ((UIImageView*)sender.subviews[1]).transform = CGAffineTransformMakeRotation( degreeTransform );
}

// Handle click on cell of add (the last cell).
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( indexPath.row == [tableView numberOfRowsInSection: indexPath.section]-1 ) {
        
        // Create new empty order and push it in array.
        OrderModel *orderModel = [[OrderModel alloc] init];
        [((TableModelWithOrders*)_arrayOfTableModelWithOrders[indexPath.section]) addOrder: orderModel];
        
        
        [OrdersDataProvider postTableOrderWithTableId: ((TableModelWithOrders*)_arrayOfTableModelWithOrders[indexPath.section]).Id
                                        responseBlock: ^(NSError *error) {
                                            if( error ) {
                                                [Alert showHTTPMethodsAlert: error];
                                            }
                                        }
         ];
        
        [self.tableView reloadData];
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
//        OrderModel *currOrder = (OrderModel*)((TableModelWithOrders*)_arrayOfTableModelWithOrders[indexSection]).arrayOfOrdersModel[indexRow];

    }
    
}


// Handle editing action.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView beginUpdates];
    if ( editingStyle == UITableViewCellEditingStyleDelete ) {
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        NSUInteger orderId = ((OrderModel*)((TableModelWithOrders*)_arrayOfTableModelWithOrders[indexPath.section]).arrayOfOrdersModel[indexPath.row]).Id;
        
        [OrdersDataProvider deleteTableOrderWithOrderId: orderId
                                          responseBlock: ^(NSError *error) {
                                              if( error ) {
                                                  [Alert showHTTPMethodsAlert: error];
                                              }
                                          }
         ];
        
        [((TableModelWithOrders*)_arrayOfTableModelWithOrders[indexPath.section]) removeOrderAtIndex: indexPath.row];
        
    } else if( editingStyle == UITableViewCellEditingStyleInsert ){
        // Here handle UITableViewCellEditingStyleInsert if we need.
    }
    [tableView endUpdates];
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

@end
