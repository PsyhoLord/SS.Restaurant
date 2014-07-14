//
//  OrderControllerTableViewController.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Mykola_Salo on 7/7/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//



#import "OrderItemsViewController.h"
#import "SidebarViewController+ConfigurationForOtherViewControllers.h"

#import "OrderModel.h"
#import "OrderItemModel.h"

#import "OrderItemCell.h"
#import "OrderTotallCell.h"

#import "MenuItemModel.h"

#import "WaiterMenuViewController.h"

#import "POrderItems.h"

static NSString *const kOrderCellIdentifier     = @"OrderItemCell";
static NSString *const kOrderTotallIdentifier   = @"OrderTotallCellIdentifier";
static NSString *const kSegueToMenuForAddItem   = @"segue_menu_add_order_item";

static float const kTransrormDimensionWidth     = 0.75;
static float const kTransrormDimensionHeight    = 1;

@implementation OrderItemsViewController
{
    // in this ptivate section var need to name with _ ( _addOrderItem because for difference with property )
    OrderItemModel *addOrderItem;
    IBOutlet UISwipeGestureRecognizer *_swipeGestureRecognizer; // need for pop self VC and go back
}


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
        // Custom initialization
    }
    return self;
}


//Sets default values for testing
- (void) setDefaultvalues
{
    
    for (int i=0; i<5; i++){
        
        addOrderItem = [[OrderItemModel alloc] init];
        MenuItemModel *addMenuItemModel = [[MenuItemModel alloc] initWithId: i
                                                     categoryId: i
                                                     description: @"kvkdskjd"
                                                     name: [NSString stringWithFormat:@"Item#%i",i]
                                                     portions: 3
                                                     price: i*1.5
                               ];
      
        addOrderItem = [[OrderItemModel alloc] initWithMenuItemModel: addMenuItemModel];
        
        addOrderItem.countOfItem = i+1;
        
        [_currentOrder.arrayOfOrderItems addObject: addOrderItem];
        
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [SidebarViewController setupSidebarConfigurationForViewController: self
                                                        sidebarButton: self.sidebarButton
                                                            isGesture: NO];
    
    UIBarButtonItem *addOrderItemButton = [[UIBarButtonItem alloc] initWithTitle: @"Add..."
                                                                           style: UIBarButtonItemStylePlain
                                                                          target: self
                                                                          action: @selector(addNewOrderItem)
                                      ];
    self.navigationItem.rightBarButtonItem = addOrderItemButton;
    
    self.title = [NSString stringWithFormat: @"Order #%i", _currentOrder.Id];
    
    _currentOrder = [[OrderModel alloc] init];
    
    [super viewDidLoad];
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
    return [_currentOrder.arrayOfOrderItems count]+1;
}


//Creating cells for Order screen and select whitch is need (OrderItem ot OrderTotall)
- (UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath: (NSIndexPath *)indexPath
{
    if ( [_currentOrder.arrayOfOrderItems count] > indexPath.row ) {
        
        OrderItemCell *orderItemCell = [tableView dequeueReusableCellWithIdentifier: kOrderCellIdentifier];
        
        [orderItemCell setDataWhithOrderItemModel: [_currentOrder.arrayOfOrderItems objectAtIndex: indexPath.row]
                                   andNumberOfRow: indexPath.row];
       
        orderItemCell.itemCountStepper.transform = CGAffineTransformMakeScale (kTransrormDimensionWidth, kTransrormDimensionHeight);
        
        [orderItemCell drawCell];
       
        orderItemCell.delegate = self;
        
        return orderItemCell;
        
    } else {
        
        OrderTotallCell *orderTotalCell = [self.tableView dequeueReusableCellWithIdentifier: kOrderTotallIdentifier];
        
        [orderTotalCell drawCellWithModel: _currentOrder];
        
        orderTotalCell.delegate = self;
        
        return orderTotalCell;
    }
    
}


//Adding new OrderItem to order, calling this method from OrderTotallCell
- (void) addNewOrderItem
{
    [self performSegueWithIdentifier: kSegueToMenuForAddItem sender: self];
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
    BOOL isInArray = 0;
    OrderItemModel *newOrderItem = [[OrderItemModel alloc] init];
    for (int i = 0; i < [_currentOrder.arrayOfOrderItems count]; i++)
    {
        newOrderItem = [_currentOrder.arrayOfOrderItems objectAtIndex: i];
        if (newOrderItem.menuItemModel.Id == menuItem.Id){
            newOrderItem.countOfItem ++;
            isInArray = 1;
        }
    }
    if (!isInArray)
    {
        OrderItemModel *newOrderItem = [[OrderItemModel alloc] initWithMenuItemModel: menuItem];
        newOrderItem.countOfItem = 1;
        [_currentOrder.arrayOfOrderItems addObject: newOrderItem];
    }
    [self.tableView reloadData];
}

//Reloading Order tableView, calling this method from OrderItemCell
- (void) redrawTable
{
    [self.tableView reloadData];
}

//removing ItemOrder from order
- (void) removeOrderItemAtIndex: (int)index
{
    [_currentOrder.arrayOfOrderItems removeObjectAtIndex: index];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
 
 
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
 }
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
