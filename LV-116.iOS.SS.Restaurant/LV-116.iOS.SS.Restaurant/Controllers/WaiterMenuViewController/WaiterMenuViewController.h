//
//  WaiterMenuViewController.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Roman Sorochak on 7/12/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "MenuViewController.h"

@protocol POrderItems;

@interface WaiterMenuViewController : MenuViewController

@property (weak, nonatomic) id<POrderItems> delegate;

@end
