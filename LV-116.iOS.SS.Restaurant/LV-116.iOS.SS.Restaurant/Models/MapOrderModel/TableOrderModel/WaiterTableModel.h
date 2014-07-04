//
//  TableOrderModel.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Roman Sorochak on 7/3/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

// class TableOrdersModel contains array of orders of one table

@class OrderModel;
@class OrderItemModel;

@interface WaiterTableModel : NSObject

@property NSUInteger capacity;
@property BOOL isFree;
@property (strong, nonatomic) NSString *name;

@property (strong, nonatomic) NSMutableArray *arrayOfOrders;

- (instancetype)initWithCapasity:(NSUInteger) capasity
                          isFree:(BOOL)isFree
                            name:(NSString*)name;

- (void)addOrder:(OrderModel*)orderModel;

- (void)addOrderItem:(OrderItemModel*)orderItemModel
             toOrder:(OrderModel*)orderModel;

@end
