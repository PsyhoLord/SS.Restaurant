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

- (instancetype) initWithTableModel: (TableModel*)tableModel
{
    if ( self = [super init] ) {
        _table = tableModel;
    }
    return self;
}

- (void)addOrder: (OrderModel*)orderModel
{
    if(_arrayOfOrders == nil){
        _arrayOfOrders = [[NSMutableArray alloc] init];
    }
    
    [_arrayOfOrders addObject:orderModel];
}

@end
