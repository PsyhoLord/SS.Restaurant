//
//  OrderControllerTableViewController.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Mykola_Salo on 7/7/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//



#import "OrderItemsViewController.h"
#import "SidebarViewController+ConfigurationForOtherViewControllers.h"
#import "UITableView+TableView_Image.h"

#import "OrderModel.h"
#import "OrderItemModel.h"

#import "OrderItemCell.h"
#import "OrderTotallCell.h"

#import "MenuItemModel.h"

#import "WaiterMenuViewController.h"

#import "POrderItems.h"

#import "OrderItemsDataProvider.h"

#import "OrderItemsDataParser.h"

#import "Alert.h"

static NSString *const kOrderCellIdentifier     = @"OrderItemCell";
static NSString *const kOrderTotallIdentifier   = @"OrderTotallCellIdentifier";
static NSString *const kSegueToMenuForAddItem   = @"segue_menu_add_order_item";

static NSString *const kAlertTitleUpdateOrder   = @"OrderUpdating";
static NSString *const kAlertMessageUpdateOrder = @"Current order nave been updeted succesfully";
static NSString *const kAlertTitleCloseOrder    = @"ClosingOrder";
static NSString *const kAlertMessageCloseOrder  = @"Order Succesfully closed";


@implementation OrderItemsViewController
{
    // in this ptivate section var need to name with _ ( _addOrderItem because for difference with property )
    OrderItemModel *addOrderItem;
    IBOutlet UISwipeGestureRecognizer *_swipeGestureRecognizer; // need for pop self VC and go back
    BOOL isOrderChanged ;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = [NSString stringWithFormat: @"Order #%i", _currentOrder.Id];
    
    [self loadOrderDataByOrderId: _currentOrder.Id];
    
    [UIViewController setBackgroundImage:self];
    
    isOrderChanged = NO;
}

//loads data about order from server using order ID
- (void) loadOrderDataByOrderId: (int)orderId
{
    [OrderItemsDataProvider loadOrderDatawithOrderId: orderId
                                       responseBlock: ^(NSArray *orderItems, NSError *error){
                                           if ( error ) {
                                               [Alert showConnectionAlert];
                                               [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                                           } else {
                                               [_currentOrder.items removeAllObjects];
                                               [_currentOrder addOrderItems: orderItems];
                                               
                                               [self.tableView reloadData];
                                               
                                               [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                                           }
                                       }];
}



// set gesture
- (void) setupGestureRecognizerConfiguration
{
    if ( _swipeGestureRecognizer == nil ) {
        _swipeGestureRecognizer =
        [[UISwipeGestureRecognizer alloc] initWithTarget: self
                                                  action: @selector(handleSwipeGestureRecognizer:)];
    }
    [self.view addGestureRecognizer: _swipeGestureRecognizer];
}

#pragma mark - handle

// return back to previous screen
- (IBAction) handleSwipeGestureRecognizer: (UISwipeGestureRecognizer *)sender
{
    [self.navigationController popViewControllerAnimated: YES];
}


#pragma mark - Table view data source

// Return the number of sections.
- (NSInteger)numberOfSectionsInTableView: (UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

// Return the number of rows in the section.
- (NSInteger)tableView: (UITableView *)tableView numberOfRowsInSection: (NSInteger)section
{
    // Return the number of rows in the section.
    return [_currentOrder.items count]+1;
}


//Creating cells for Order screen and select whitch is need (OrderItem ot OrderTotall)
- (UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath: (NSIndexPath *)indexPath
{
    if ( [_currentOrder.items count] > indexPath.row ) {
        
        OrderItemCell *orderItemCell = [tableView dequeueReusableCellWithIdentifier: kOrderCellIdentifier];
        
        [orderItemCell setDataWhithOrderItemModel: [_currentOrder.items objectAtIndex: indexPath.row]
                                   andNumberOfRow: indexPath.row];
        
        [orderItemCell drawCell];
        
        orderItemCell.delegate = self;
        
        orderItemCell.backgroundColor = [UIColor colorWithRed:0.99 green:0.99 blue:0.99 alpha:0.6];
        
        return orderItemCell;
        
    } else {
        
        OrderTotallCell *orderTotalCell = [self.tableView dequeueReusableCellWithIdentifier: kOrderTotallIdentifier];
        
        [orderTotalCell drawCellWithModel: _currentOrder andChangedOrderStatus: isOrderChanged];
        
        orderTotalCell.delegate = self;
        
        orderTotalCell.backgroundColor = [UIColor colorWithRed:0.99 green:0.99 blue:0.99 alpha:0.4];
        
        return orderTotalCell;
    }
    
}


// do smth before segue on next scrin - WaiterMenuViewController
- (void) prepareForSegue: (UIStoryboardSegue *)segue sender: (id)sender
{
    WaiterMenuViewController *destWaiterMenuVC =  segue.destinationViewController;
    destWaiterMenuVC.delegate = self;
    destWaiterMenuVC.title = @"Add item";
}


// method from POrderItem protocol
// calls by WaiterMenuViewController and OrderItemsViewController
- (void) didAddedOrderItem: (MenuItemModel*)menuItem
{
    OrderItemModel *newOrderItem = [[OrderItemModel alloc] initWithMenuItemModel: menuItem];
    newOrderItem.amount = 1;
    [_currentOrder.items addObject: newOrderItem];
    for (int i = 0; i < [_currentOrder.items count]-1; i++){
        newOrderItem = [_currentOrder.items objectAtIndex: i];
        if (newOrderItem.menuItemModel.Id == menuItem.Id){
            newOrderItem.amount ++;
            [_currentOrder.items removeLastObject];
            break;
        }
    }
    isOrderChanged = YES;
    [self.tableView reloadData];
}

//Reloading Order tableView, calling this method from OrderItemCell
- (void) redrawTable
{
    isOrderChanged = YES;
    [self.tableView reloadData];
}

//removing ItemOrder from order
- (void) removeOrderItemAtIndex: (int)index
{
    OrderItemModel *orderItemToRemove = [[OrderItemModel alloc] init];
    orderItemToRemove = [_currentOrder.items objectAtIndex: index];
    [_currentOrder.items removeObjectAtIndex:index];
    orderItemToRemove.Id = -orderItemToRemove.Id;
    [_currentOrder.items insertObject:orderItemToRemove atIndex:index];
    [self sendUpdateOrder];
    [_currentOrder.items removeObjectAtIndex:index];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//Getting started sendibg OrderUpdate request to server
- (void) sendUpdateOrder
{
    NSData *dataFromOrder = [OrderItemsDataParser parseOrderToData: _currentOrder];
    [OrderItemsDataProvider sendDataFromOrderToUpdate:dataFromOrder
                                        responseBlock:^(NSError *error){
                                            if(error){
                                                [Alert showConnectionAlert];
                                            }
                                            [Alert showUpdateOrderInfoSuccesfullWhithTitle: kAlertTitleUpdateOrder
                                                                                andMessage: kAlertMessageUpdateOrder];
                                            isOrderChanged = NO;
                                            [self.tableView reloadData];
                                        }
     ];
    //send UPD
}

//handled "served" property for orderItem and "closed" property for orderTotallCell
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_currentOrder.items count] > indexPath.row) {
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            OrderItemModel *currentOrderItem;
            currentOrderItem = [_currentOrder.items objectAtIndex: indexPath.row];
            currentOrderItem.served = YES ;
            isOrderChanged = YES;
            [self.tableView reloadData];
        }
    } else {
        // here handeled closing order
        _currentOrder.closed = YES;
        [OrderItemsDataProvider closeOrder: _currentOrder.Id
                             responseBlock: ^(NSError *error){

                                     if(error){
                                         [Alert showConnectionAlert];
                                     }
                                     [Alert showUpdateOrderInfoSuccesfullWhithTitle: kAlertTitleCloseOrder
                                                                         andMessage: kAlertMessageCloseOrder
                                      ];
                                     [self.navigationController popViewControllerAnimated:YES];
                             }
         ];
        
    }
    
}

//changed "delete" text (appears when swipe left) for each cell
- (NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_currentOrder.items count] == indexPath.row) {
        return @"Close Order";
    } else {
        return @"Served";
    }
}


@end
