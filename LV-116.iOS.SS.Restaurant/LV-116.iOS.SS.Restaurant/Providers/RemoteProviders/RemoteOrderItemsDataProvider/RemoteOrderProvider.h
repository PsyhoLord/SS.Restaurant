//
//  RemoteOrderProvider.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Mykola_Salo on 7/16/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OrderModel;

@interface RemoteOrderProvider : NSObject

// Load order with orderItems by OrderId.
+ (void)loadOrderItemsWithId:(int)orderId responseBlock:(void (^)(NSArray*, NSError*))callback;

// Updates Order by sending data
+ (void) sendDataFromOrderToUpdate: (NSData * )data responseBlock: (void (^)(NSError*))callback;

//Closing Order by specifed ID
+ (void) closeOrderById: (int)orderId responseBlock: (void (^)(NSError*)) callback;

@end
