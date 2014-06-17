//
//  MenuViewController.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Administrator on 6/6/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuCategory.h"
//#import "PMenuDataNotification.h"

@interface MenuViewController : UITableViewController //<PMenuDataNotification>

@property (strong, nonatomic) MenuCategory *currentCategory;

@end
