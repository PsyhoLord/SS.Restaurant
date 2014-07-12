//
//  RemoteOrdersDataProvider.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Oleg Hnidets on 7/9/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RemoteOrdersDataProvider : NSObject

// Load orders on one table using tableId.
+ (void)loadTableOrdersWithId:(int)tableId responseBlock:(void (^)(NSArray*, NSError*))callback;

// Delete the one order on table using orderId.
+ (void)deleteTableOrderWithOrderId:(int)orderId responseBlock:(void (^)(NSError*))callback;

+ (void)postTableOrderWithTableId:(int)tableId responseBlock:(void (^)(NSError*))callback;

@end
