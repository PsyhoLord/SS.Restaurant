//
//  TestDropTableView.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Oleg Hnidets on 7/6/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WaiterMapModel;

@interface OrdersViewController : UITableViewController

@property (strong, nonatomic) WaiterMapModel *waiterMapModel;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@end
