//
//  POrderItems.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Mykola_Salo on 7/12/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

@class MenuItemModel;

#warning - comment all your code !!! 

@protocol POrderItems <NSObject>

// calls when user has added menu item
- (void) didAddedOrderItem: (MenuItemModel*)menuItem;

#warning these methods are required

@optional

-(void) redrawTable;

-(void) addNewOrderItem;

-(void) removeOrderItemAtIndex: (int)index;

@end
