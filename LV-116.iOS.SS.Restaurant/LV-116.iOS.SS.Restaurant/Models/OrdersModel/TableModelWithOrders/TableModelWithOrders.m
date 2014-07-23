//
//  ContainerOrderModel.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Oleg Hnidets on 7/9/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "TableModelWithOrders.h"
#import "OrderModel.h"
#import "MapModel.h"


@implementation TableModelWithOrders

- (instancetype)initWithTableModel:(TableModel*)table
{
    if( self = [super initWithTableModel: table] ) {
    }
    return self;
}

// Add one order in array orders from OrderModel.
- (void)addOrder:(OrderModel*)order
{
    if( _orders == nil ){
        _orders = [[NSMutableArray alloc] init];
    }
    [_orders addObject: order];
}

// Add few orders from array.
- (void)addOrders:(NSArray*)orders
{
    if( _orders == nil ){
        _orders = [[NSMutableArray alloc] init];
    }
    [_orders addObjectsFromArray: orders];
}

// Remove one order at index.
- (void)removeOrderAtIndex:(NSUInteger)index
{
    if( _orders != nil ){
        [_orders removeObjectAtIndex: index];
    }
}

// Remove all orders.
- (void)removeAllOrders
{
    [_orders removeAllObjects];
    _orders = nil;
}

@end
