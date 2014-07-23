//
//  DescriptionViewController.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Oleg Hnidets on 7/12/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//



@class MenuItemModel;

@interface ItemDescriptionViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@property (strong, nonatomic) NSArray *items;
@property (assign, nonatomic) int index;

@end
