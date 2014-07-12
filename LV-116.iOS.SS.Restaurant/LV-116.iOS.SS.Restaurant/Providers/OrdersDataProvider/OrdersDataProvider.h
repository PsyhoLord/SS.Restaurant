//
//  TableOrdersProvider.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Oleg Hnidets on 7/9/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OrderModel;

@interface OrdersDataProvider : NSObject

// Load data about orders on one table
+ (void)loadTableOrdersDataWithTableId:(int)tableId responseBlock:(void (^)(NSArray*, NSError*))callback;

// You can delete the one order on table.
+ (void)deleteTableOrderWithOrderId:(int)orderId responseBlock:(void (^)(NSError*))callback;


+ (void)postTableOrderWithTableId:(int)tableId responseBlock:(void (^)(NSError*))callback;

@end