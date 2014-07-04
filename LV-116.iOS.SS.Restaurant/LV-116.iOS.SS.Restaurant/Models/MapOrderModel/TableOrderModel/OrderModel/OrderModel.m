//
//  OrderModel.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Roman Sorochak on 7/3/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "OrderModel.h"

@implementation OrderModel

- (instancetype)init
{
    if ( self = [super init] ) {
        self.arrayOfOrderItem = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
