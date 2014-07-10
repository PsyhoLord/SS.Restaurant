//
//  ContainerOrderModel.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Oleg Hnidets on 7/9/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "TableModel.h"

// Class TableModelWithOrders will contain whole data about one table.
// Difference between TableModel in that it has orders model array.

@class OrderModel;

@interface TableModelWithOrders : TableModel

@property (strong,nonatomic) NSMutableArray *arrayOfOrdersModel;

// Add one order in arrayOfOrdersModel from OrderModel.
-(void)addOrder:(OrderModel*)orderModel;

// Add few orders from array in arrayOfOrdersModel.
-(void)addArrayOfOrders:(NSArray*)orderModel;

-(instancetype)initWithTableModel:(TableModel*)tableModel;

@end
