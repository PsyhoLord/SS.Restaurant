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
                                responseBlock: ^(NSArray *arrayOfOrderItems, NSError *error){
                                    callback (arrayOfOrderItems, error);
                                }
     ];
}

@end
