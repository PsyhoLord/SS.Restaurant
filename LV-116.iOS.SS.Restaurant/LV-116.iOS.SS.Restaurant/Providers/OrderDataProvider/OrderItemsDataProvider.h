//
//  OrderDataProvider.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Mykola_Salo on 7/16/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

@class OrderModel;

@interface OrderItemsDataProvider : NSObject

//loads Order info whith orderItems by specifeid OrderId
+ (void) loadOrderDatawithOrderId:(int) OrderId responseBlock : (void (^)(NSArray *, NSError*))callback;

//Send UPD Order request to server
+ (void) sendDataFromOrderToUpdate: (NSData *) data responseBlock : (void (^)(NSError *))callback;

//Closing order by spesyfied ID of order
+ (void) closeOrder: (int) orderId responseBlock: (void (^)(NSError *))callback;
@end
