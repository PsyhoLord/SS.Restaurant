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

static NSString *const orderCellIdentifier   = @"OrderItemCell";
static NSString *const orderTotallIdentifier = @"TotallOrderCell";

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
      
        addOrderItem.menuItemModel.name=[NSString stringWithFormat:@"Item#%i",i];
        
        addOrderItem.menuItemModel.price = i*1.5;
        
        addOrderItem.countOfItem=i;
        
        [_currentOrder.arrayOfOrderItem addObject:addOrderItem];
        
    }
    
    
}

- (void)viewDidLoad
{
    _currentOrder=[[OrderModel alloc] init];
    
    [super viewDidLoad];
    [self setDefaultvalues];
    
    
    
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
    return [_currentOrder.arrayOfOrderItem count]+1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_currentOrder.arrayOfOrderItem count]>[indexPath row])
    {
    OrderItemCell *orderItemCell = [tableView dequeueReusableCellWithIdentifier:orderCellIdentifier];
        if (orderItemCell==nil)
        {
            orderItemCell=[[OrderItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderCellIdentifier];
        
        }
    
    
    OrderItemModel * tmp=[[OrderItemModel alloc] init];
    tmp=[_currentOrder.arrayOfOrderItem objectAtIndex:[indexPath row]];
    [orderItemCell drawCellWithModel:tmp];
        return orderItemCell;
        
    }
    else
    {
        
        OrderTotallCell *totallOrderCell=[tableView dequeueReusableCellWithIdentifier:orderTotallIdentifier];
        if (totallOrderCell==nil)
        {
            totallOrderCell = [[OrderTotallCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderTotallIdentifier];
        }
        //totallOrderCell.TotallPrice.text=@"All Your Money";
        //totallOrderCell.
        //HERE NEED TO ADD "ADD CUSTOM CELL"
        [totallOrderCell drawCellWithModel:_currentOrder];
        
        return totallOrderCell;
        
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
