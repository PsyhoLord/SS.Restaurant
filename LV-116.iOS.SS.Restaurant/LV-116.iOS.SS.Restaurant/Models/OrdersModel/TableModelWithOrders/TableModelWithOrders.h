//
//  ContainerOrderModel.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Oleg Hnidets on 7/9/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "TableModel.h"

// Class TableModelWithOrders will contain whole data about one table.
// Difference between TableModel in that it has array of orders model.

@class OrderModel;

@interface TableModelWithOrders : TableModel

@property (strong,nonatomic) NSMutableArray *orders;

-(instancetype)initWithTableModel:(TableModel*)table;

// Add one order in array orders from OrderModel.
-(void)addOrder:(OrderModel*)order;

// Add few orders from array.
-(void)addOrders:(NSArray*)orders;

// Remove one order at index.
-(void)removeOrderAtIndex:(NSUInteger)index;

@end
