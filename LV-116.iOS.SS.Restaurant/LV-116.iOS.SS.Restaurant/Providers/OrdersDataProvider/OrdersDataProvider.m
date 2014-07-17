//
//  TableOrdersProvider.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Oleg Hnidets on 7/9/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "OrdersDataProvider.h"
#import "RemoteOrdersDataProvider.h"

#import "MapModel.h"
#import "TableModelWithOrders.h"

@class TableModelWithOrders;

@implementation OrdersDataProvider

#pragma mark - Load table orders.
// load remote data of orders on one table using tableId
// call block when model have created
+ (void)loadTableOrdersDataWithTableId:(int)tableId responseBlock:(void (^)(NSArray*, NSError*))callback
{
    [RemoteOrdersDataProvider loadTableOrdersWithId: (int)tableId
                                      responseBlock: ^(NSArray *arrayOfOrderModel, NSError *error) {
                                              callback(arrayOfOrderModel, error);
                                      }
     ];
}

#pragma mark - HTTP methods.
#pragma mark - DELETE
// Delete the one order on table using orderId.
+ (void)deleteTableOrderWithOrderId:(int)orderId responseBlock:(void (^)(NSError*))callback
{
    [RemoteOrdersDataProvider deleteTableOrderWithOrderId:orderId
                                            responseBlock:^(NSError *error) {
                                                callback(error);
                                            }
     ];
}

#pragma mark - POST

// Post the one order on table using tableId.
+ (void)postTableOrderWithTableModel:(int)tableId responseBlock:(void (^)(NSUInteger,  NSError*))callback
{
    [RemoteOrdersDataProvider postTableOrderWithTableModel:tableId
                                             responseBlock:^(NSUInteger orderId, NSError *error) {
                                                 callback(orderId, error);
                                             }
    ];
}

@end
