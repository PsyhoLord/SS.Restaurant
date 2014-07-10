//
//  OrderModel.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Roman Sorochak on 7/3/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//


// class OrderModel will contain data of one order

@interface OrderModel : NSObject

@property int Id;
@property BOOL closed;
@property (strong, nonatomic) NSMutableArray *arrayOfOrderItems;
//@property int table;
@property int tableId;
@property (strong,nonatomic) NSString *timestamp;
//@property int user;
@property int userId;

- (instancetype)initWithId:(int)Id isClosed:(BOOL)closed tableId:(int)tableId timestamp:(NSString*)timestamp userId:(int)userId;

@end
