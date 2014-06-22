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
    NSMutableArray *_tableArray;
}

-(void)addTables:(TableModel*)table
{
    if( _tableArray ){
        [_tableArray addObject:table];
    } else{
        _tableArray = [[NSMutableArray alloc] init];
    }
}

@end
