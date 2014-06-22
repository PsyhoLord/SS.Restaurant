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
{
    NSMutableArray *_tableModelArray;
}

// get object of MapModel which contains array of TableModels
- (MapModel*)getMapData
{
    return self;
}

// add TableModel to an array of TableModels
- (void)addTableModel:(TableModel*)tableModel
{
    if( _tableModelArray ){
        [_tableModelArray addObject:tableModel];
    } else{
        _tableModelArray = [[NSMutableArray alloc] init];
    }
}

@end
