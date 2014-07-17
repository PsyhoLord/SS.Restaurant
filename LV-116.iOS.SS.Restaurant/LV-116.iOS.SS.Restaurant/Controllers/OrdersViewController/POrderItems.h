//
//  POrderItems.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Mykola_Salo on 7/12/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

@class MenuItemModel;

@protocol POrderItems <NSObject>

// calls when user has added menu item
- (void) didAddedOrderItem: (MenuItemModel*)menuItem;

- (void) redrawTable;

- (void) addNewOrderItem;

- (void) removeOrderItemAtIndex: (int)index;

- (void) sendUpdateOrder;

@end
