//
//  MainViewController.h
//  SideBar
//
//  Created by Roman Sorochak on 7/4/14.
//  Copyright (c) 2014 Roman Sorochak. All rights reserved.
//


@class WaiterTableModel;


@interface OrdersViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@property (weak,nonatomic) WaiterTableModel *currentWaiterTable;

@property (weak, nonatomic) IBOutlet UILabel *label1;

@end
