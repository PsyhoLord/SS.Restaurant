//
//  SidebarViewController.h
//  SidebarDemo
//
//  Created by Simon on 29/6/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

@class WaiterMapModel;

@interface SidebarViewController : UITableViewController

@property (strong, nonatomic) WaiterMapModel *waiterMapModel;
@property (weak, nonatomic) IBOutlet UIImageView *roleImage;
@end
