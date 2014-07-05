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

- (instancetype) initWithMapModel:(MapModel*)mapModel
{
    if ( self = [super init] ) {
        _arrayOfTableModel = [[NSMutableArray alloc] init];
        
        [mapModel.arrayTableModel enumerateObjectsUsingBlock:^(id tableModel, NSUInteger indexOfTableModel, BOOL *stop) {
            
            WaiterTableModel *waiterTableModel = [[WaiterTableModel alloc] initWithTableModel:tableModel];
            [_arrayOfTableModel addObject:waiterTableModel];
            
        }];
    }
    return self;
}

@end
