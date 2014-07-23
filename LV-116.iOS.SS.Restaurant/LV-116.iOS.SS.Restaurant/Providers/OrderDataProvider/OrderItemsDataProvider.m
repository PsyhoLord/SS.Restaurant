//
//  OrderDataProvider.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Mykola_Salo on 7/16/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "OrderItemsDataProvider.h"
#import "OrderModel.h"

#import "RemoteOrderProvider.h"


@implementation OrderItemsDataProvider

// load remote data orderItems  using orderId
// call block when model have created
+ (void) loadOrderDatawithOrderId:(int) OrderId responseBlock : (void (^)(NSArray*, NSError*))callback
{
    [RemoteOrderProvider loadOrderItemsWithId: OrderId
                                responseBlock: ^(NSArray *orderItems, NSError *error){
                                    callback (orderItems, error);
                                }
     ];
}

//Send UPD Order request to server
+ (void) sendDataFromOrderToUpdate: (NSData *) data responseBlock : (void (^)(NSError *))callback
{
    [RemoteOrderProvider sendDataFromOrderToUpdate: data
                                     responseBlock: ^(NSError * error){
                                         callback (error);
                                     }
     ];
}

+ (void) closeOrder: (int)orderId responseBlock: (void (^)(NSError *))callback
{
    [RemoteOrderProvider closeOrderById:orderId
                          responseBlock:^(NSError *error){
                              callback (error);
                          }
     ];
}

@end
