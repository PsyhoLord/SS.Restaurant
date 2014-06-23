//
//  MapModel.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Oleg Hnidets on 6/21/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "MapModel.h"
#import "TableModel.h"

@implementation MapModel

// get object of MapModel which contains array of TableModels
- (MapModel*)getMapData
{
    return self;
}

// add TableModel to an array of TableModels
- (void)addTableModel:(TableModel*)tableModel
{
    if( _tableModelArray == nil ) {
        _tableModelArray = [[NSMutableArray alloc] init];
    }
    [_tableModelArray addObject:tableModel];
}

@end
