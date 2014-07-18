//
//  OrderDataParser.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Mykola_Salo on 7/16/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "PDataParser.h"

@class OrderModel;

@interface OrderItemsDataParser : NSObject <PDataParser>

//Making NSData object (in server needed format) from OrderModel object
+ (NSData*) unParseOrder: (OrderModel*) orderModel;

@end
