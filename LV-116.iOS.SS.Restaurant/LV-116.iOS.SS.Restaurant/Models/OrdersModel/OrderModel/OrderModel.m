//
//  OrderModel.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Roman Sorochak on 7/3/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "OrderModel.h"

@implementation OrderModel

- (instancetype)initWithId: (int)Id
                  isClosed: (BOOL)closed
                   tableId: (int)tableId
                 timestamp: (NSString*)timestamp
                    userId: (int)userId
{
    if ( self = [super init] ) {
        self.arrayOfOrderItems = [[NSMutableArray alloc] init];  // need to think where we will alloc 
        self.Id                = Id;
        self.closed            = closed;
        self.tableId           = tableId;
        self.timestamp         = timestamp;
        self.userId            = userId;
    }
    return self;
}

-(instancetype) init
{
    if (self = [super init]){
        self.arrayOfOrderItems = [[NSMutableArray alloc] init];
        
    }
    return  self;
}

- (void) addArrayOfOrderItems:(NSArray *) arrayOfOrderItems
{
    if (_arrayOfOrderItems == nil){
        _arrayOfOrderItems = [[NSMutableArray alloc] initWithArray: arrayOfOrderItems copyItems: YES];
    }
    [_arrayOfOrderItems addObjectsFromArray: arrayOfOrderItems];
}


@end
