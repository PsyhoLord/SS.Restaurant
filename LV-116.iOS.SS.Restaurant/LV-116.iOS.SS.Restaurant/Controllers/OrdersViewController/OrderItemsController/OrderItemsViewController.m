//
//  OrderControllerTableViewController.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Mykola_Salo on 7/7/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "OrderItemsViewController.h"
#import "OrderModel.h"
#import "OrderItemCell.h"
#import "OrderItemModel.h"
#import "MenuItemModel.h"
#import "OrderTotallCell.h"

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


- (void) setDefaultvalues
{
  
    //addOrderItem =[[OrderItemModel alloc] init];
    
    for (int i=0; i<5; i++)
    {
        addOrderItem =[[OrderItemModel alloc] init];
        MenuItemModel *temp=[[MenuItemModel alloc] initWithId:i categoryId:i description:@"kvkdskjd" name:[NSString stringWithFormat:@"Item#%i",i] portions:3 price:i*1.5];
      
        /*temp.name=[NSString stringWithFormat:@"Item#%i",i];
        
        temp.price = i*1.5;
        */
        addOrderItem = [[OrderItemModel alloc] initWithMenuItemModel:temp];
        
        addOrderItem.countOfItem=i;
        
        [_currentOrder.arrayOfOrderItems addObject:addOrderItem];
        
    }
    
    
}

- (void)viewDidLoad
{
   _currentOrder=[[OrderModel alloc] init];
    [self setDefaultvalues];
    [super viewDidLoad];
 
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_currentOrder.arrayOfOrderItems count]+1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_currentOrder.arrayOfOrderItems count]>indexPath.row) {
        
        OrderItemCell *orderItemCell = [tableView dequeueReusableCellWithIdentifier:kOrderTotallIdentifier];
       /* if (orderItemCell==nil)
        {
            orderItemCell=[[OrderItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kOrderCellIdentifier];
        
        }*/
    
        
        orderItemCell.currentOrderItem = [_currentOrder.arrayOfOrderItems objectAtIndex:indexPath.row];
        [orderItemCell drawCell];
        return orderItemCell;
        
    }
    else {
        
//        OrderTotallCell *totallOrderCell=[tableView dequeueReusableCellWithIdentifier:orderTotallIdentifier];
//        if (totallOrderCell==nil)
//        {
//            totallOrderCell = [[OrderTotallCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderTotallIdentifier];
//        }
//        //totallOrderCell.TotallPrice.text=@"All Your Money";
//        //totallOrderCell.
//        //HERE NEED TO ADD "ADD CUSTOM CELL"
//        [totallOrderCell drawCellWithModel:_currentOrder];
//        
//        return totallOrderCell;

        
        OrderTotallCell *orderTotalCell = [self.tableView dequeueReusableCellWithIdentifier: kOrderTotallIdentifier];
        
        [orderTotalCell drawCellWithModel:_currentOrder];
        
        return orderTotalCell;
    }
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([_currentOrder.arrayOfOrderItems count]==indexPath.row){
        
        MenuItemModel *menuItemModel=[[MenuItemModel alloc] init];
        
        menuItemModel.name=[NSString stringWithFormat:@"Item"];
        
        
        menuItemModel.price = 5*1.5;
        
        addOrderItem=[[OrderItemModel alloc] initWithMenuItemModel:menuItemModel];
        
        
        addOrderItem.countOfItem=3;
        
        [_currentOrder.arrayOfOrderItems addObject:addOrderItem];
        
        [tableView reloadData];
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
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
