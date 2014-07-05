//
//  TableOrderModel.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Roman Sorochak on 7/3/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

// class TableOrdersModel contains array of orders of one table

@class TableModel;
@class OrderModel;
@class OrderItemModel;

@interface WaiterTableModel : NSObject

@property (strong, nonatomic) TableModel *table;

@property (strong, nonatomic) NSMutableArray *arrayOfOrders;

- (instancetype) initWithTableModel:(TableModel*)tableModel;

@end
