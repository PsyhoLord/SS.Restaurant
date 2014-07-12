//
//  MenuViewController.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Administrator on 6/6/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

@class MenuCategoryModel;

@interface MenuViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (strong, nonatomic) MenuCategoryModel *currentCategory;
@property BOOL isNeedGestureForCallSidebar; // if YES, than gesture works for call sidebar
@end