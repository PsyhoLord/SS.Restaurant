//
//  OrderModel.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Roman Sorochak on 7/3/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//


// class OrderModel will contain data of one order
@class OrderItemModel;

@interface OrderModel : NSObject

@property (assign, nonatomic) int Id;
@property (assign, nonatomic) BOOL closed;
@property (assign, nonatomic) int tableId;
@property (assign, nonatomic) int userId;
@property (strong, nonatomic) NSMutableArray *items;

@property (strong,nonatomic) NSString *timestamp;


- (instancetype)initWithId: (int)Id isClosed: (BOOL)closed tableId: (int)tableId timestamp: (NSString*)timestamp userId: (int)userId;

- (instancetype) init;

- (void) addOrderItems:(NSArray *) newOrderItems;

@end
