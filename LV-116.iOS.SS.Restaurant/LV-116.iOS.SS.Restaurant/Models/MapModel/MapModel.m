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

// add TableModel to an array of TableModels
- (void)addTableModel:(TableModel*)table
{
    if( _tables == nil ) {
        _tables = [[NSMutableArray alloc] init];
    }
    [_tables addObject:table];
}

@end
