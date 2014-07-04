//
//  MapOrderModel.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Roman Sorochak on 7/3/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "WaiterMapModel.h"
#import "WaiterTableModel.h"
#import "MapModel.h"
#import "TableModel.h"

@implementation WaiterMapModel

- (instancetype)init
{
    if ( self = [super init] ) {
        self.arrayOfTableModel = [[NSMutableArray alloc] init];
    }
    return self;
}

// add TableModel to an array of TableModels
- (void)addTableModel:(WaiterTableModel*)tableModel
{
    [_arrayOfTableModel addObject:tableModel];
}

@end
