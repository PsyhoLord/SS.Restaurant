//
//  OrderModel.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Roman Sorochak on 7/3/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "OrderModel.h"

@implementation OrderModel

- (instancetype) init
{
    if (self = [super init]){
        _items = [[NSMutableArray alloc] init];
        
    }
    return  self;
}

- (instancetype)initWithId: (int)Id
                  isClosed: (BOOL)closed
                   tableId: (int)tableId
                 timestamp: (NSString*)timestamp
                    userId: (int)userId
{
    if ( self = [super init] ) {
        _items = [[NSMutableArray alloc] init];  // need to think where we will alloc
        _Id                = Id;
        _closed            = closed;
        _tableId           = tableId;
        _timestamp         = timestamp;
        _userId            = userId;
    }
    return self;
}



// Adds array of items.
- (void) addOrderItems:(NSArray *) newOrderItems
{
    if (_items == nil) {
        _items = [[NSMutableArray alloc] initWithArray: newOrderItems copyItems: YES];
    }
    [_items addObjectsFromArray: newOrderItems];
}


@end
