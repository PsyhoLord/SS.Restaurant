//
//  MapDataParser.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Mykola on 6/23/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "MapDataParser.h"
#import "MapModel.h"
#import "TableModel.h"

static NSString *const kTableID          = @"Id";
static NSString *const kTableCapacity    = @"Capacity";
static NSString *const kTableHeight      = @"Height";
static NSString *const kTableisActive    = @"IsActive";
static NSString *const kTableIsFree      = @"IsFree";
static NSString *const kTableIsRound     = @"IsRound";
static NSString *const kTableName        = @"Name";
static NSString *const kTableRotation    = @"Rotation";
static NSString *const kTablewWidth      = @"Width";
static NSString *const kTableX           = @"X";
static NSString *const kTableY           = @"Y";

@implementation MapDataParser

+ (id)parse:(NSData*) data parsingError:(NSError**) parseError
{
    NSError *parsingError;
    NSMutableDictionary *responseForTableMap = [NSJSONSerialization JSONObjectWithData: data
                                                                               options: NSJSONReadingMutableContainers
                                                                                 error: &parsingError];
    if ( parsingError ) {
        *parseError = parsingError;
        return nil;
    }
    //Calling a method, which will be convert data from JSON (type NSData) to MapModel (own type)
    return [self parseDictionary:responseForTableMap];
}

+ (MapModel*)parseDictionary:(NSMutableDictionary*)tables
{
    MapModel *mapModel = [[MapModel alloc] init];
    
    for ( NSMutableDictionary *tableDictionary in tables ) {
        
        TableModel *table = [self createNewTable:tableDictionary];
        [mapModel addTableModel:table];
        
    }
    return mapModel;
}

+ (TableModel*)createNewTable:(NSDictionary*)tableDictionary
{
    TableModel *table;
    table = [[TableModel alloc] initWithId:[[tableDictionary objectForKey:kTableID] intValue]
                                  Capacity:[[tableDictionary objectForKey:kTableCapacity]intValue]
                                    height:[[tableDictionary objectForKey:kTableHeight]intValue]
                                  isActive:[[tableDictionary objectForKey:kTableisActive] boolValue]
                                    isFree:[[tableDictionary objectForKey:kTableIsFree]boolValue]
                                   isRound:[[tableDictionary objectForKey:kTableIsRound]intValue]
                                      name:[tableDictionary  objectForKey:kTableName]
                                  rotation:[[tableDictionary objectForKey:kTableRotation]intValue]
                                     width:[[tableDictionary objectForKey:kTablewWidth]intValue]
                                    coordX:[[tableDictionary objectForKey:kTableX]intValue]
                                    coordY:[[tableDictionary objectForKey:kTableY]intValue]
             ];
    return table;
}

@end
