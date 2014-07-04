//
//  TableOrderModel.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Roman Sorochak on 7/3/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "WaiterTableModel.h"
#import "OrderModel.h"

@implementation WaiterTableModel

- (instancetype)init
{
    if ( self = [super init] ) {
        self.arrayOfOrders = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)addOrder:(OrderModel*)orderModel
{
    OrderModel *newOrderModel = [[OrderModel alloc] init];
    [_arrayOfOrders addObject:newOrderModel];
}

@end
