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

+ (void)loadTableOrdersDataWithTableId:(int)tableId andWithBlock:(void (^)(NSArray*, NSError*))callback;

@end
