//
//  OrderControllerTableViewController.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Mykola_Salo on 7/7/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderModel;
@class OrderItemCell;
@class OrderItemModel;
@class OrderTotallCell;
@class MenuItemModel;
//@class MenuItemModel;

@interface OrderItemsViewController : UITableViewController

@property (strong,nonatomic)OrderModel *currentOrder;


@end
