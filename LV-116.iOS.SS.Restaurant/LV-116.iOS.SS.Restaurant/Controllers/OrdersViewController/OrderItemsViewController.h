//
//  OrderControllerTableViewController.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Mykola_Salo on 7/7/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//
#import "POrderItems.h"

@protocol POrderItems;

@class OrderModel;
@class OrderItemModel;
@class OrderItemCell;
@class OrderTotallCell;

@class MenuItemModel;

@interface OrderItemsViewController : UITableViewController <POrderItems>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (strong,nonatomic) OrderModel *currentOrder;
@property (strong,nonatomic) OrderModel *Order;
@end
