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

@end
