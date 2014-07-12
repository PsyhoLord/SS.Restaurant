//
//  OrderControllerTableViewController.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Mykola_Salo on 7/7/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "OrderItemsViewController.h"

#import "OrderModel.h"
#import "OrderItemModel.h"

#import "OrderItemCell.h"
#import "OrderTotallCell.h"

#import "MenuItemModel.h"


static NSString *const kOrderCellIdentifier    = @"OrderItemCell";
static NSString *const kOrderTotallIdentifier  = @"OrderTotallCellIdentifier";

@implementation OrderItemsViewController
{
    OrderItemModel *addOrderItem;
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
        
        MenuItemModel *temp = [[MenuItemModel alloc] initWithId: i
                                                     categoryId: i
                                                     description: @"kvkdskjd"
                                                     name: [NSString stringWithFormat:@"Item#%i",i]
                                                     portions: 3
                                                     price: i*1.5
                               ];
      
        addOrderItem = [[OrderItemModel alloc] initWithMenuItemModel: temp];
        
        addOrderItem.countOfItem = i+1;
        
        [_currentOrder.arrayOfOrderItems addObject: addOrderItem];
        
    }
    
    
}


- (void)viewDidLoad
{
    _currentOrder = [[OrderModel alloc] init];
    
    [self setDefaultvalues];
    
    [super viewDidLoad];
}


#pragma mark - Table view data source

// Return the number of sections.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
 
    return 1;
}

// Return the number of rows in the section.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [_currentOrder.arrayOfOrderItems count]+1;
}


//Creating cells for Order screen and select whitch is need (OrderItem ot OrderTotall)
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( [_currentOrder.arrayOfOrderItems count] > indexPath.row ) {
        
        OrderItemCell *orderItemCell = [tableView dequeueReusableCellWithIdentifier: kOrderCellIdentifier];
        
        //orderItemCell.currentOrderItem = [_currentOrder.arrayOfOrderItems objectAtIndex: indexPath.row];
        
        [orderItemCell setDataWhithOrderItemModel:[_currentOrder.arrayOfOrderItems objectAtIndex: indexPath.row]
                                   andNumberOfRow:indexPath.row];
        
        [orderItemCell drawCell];
        
        orderItemCell.itemCountStepper.transform = CGAffineTransformMakeScale(0.75, 1);
       
        orderItemCell.delegate = self;
        
        return orderItemCell;
        
    }
    else {
        
        OrderTotallCell *orderTotalCell = [self.tableView dequeueReusableCellWithIdentifier: kOrderTotallIdentifier];
        
        [orderTotalCell drawCellWithModel: _currentOrder];
        
        orderTotalCell.delegate = self;
        
        return orderTotalCell;
    }
    
}


//Adding new OrderItem to order, calling this method from OrderTotallCell
- (void) addNewOrderItem
{
    MenuItemModel *menuItemModel = [[MenuItemModel alloc] init];
    
    menuItemModel.name = [NSString stringWithFormat: @"Item"];
    
    menuItemModel.price = 5*1.5;
    
    addOrderItem = [[OrderItemModel alloc] initWithMenuItemModel: menuItemModel];
    
    addOrderItem.countOfItem = 3;
    
    [_currentOrder.arrayOfOrderItems addObject: addOrderItem];
    
    [self.tableView reloadData];
}

//Removing OrderItem from _currentOrder
- (void) removeOrderItemAtIndex:(int)index
{
    [_currentOrder.arrayOfOrderItems removeObjectAtIndex: index];
}

//Reloading Order tableView, calling this method from OrderItemCell
- (void) redrawTable
{
    [self.tableView reloadData];
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
