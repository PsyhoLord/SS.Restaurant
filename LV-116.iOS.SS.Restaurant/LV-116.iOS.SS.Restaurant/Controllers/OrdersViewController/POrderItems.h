//
//  POrderItems.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Mykola_Salo on 7/12/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

//Conecting OrderItemsViewController whith OrderItemCell and OrderTotallCell
@protocol POrderItems <NSObject>

@optional
-(void) redrawTable;

-(void) addNewOrderItem;

-(void) removeOrderItemAtIndex: (int)index;

@end
