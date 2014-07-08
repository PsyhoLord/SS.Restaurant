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

+ (MapModel*)parseDictionary:(NSMutableDictionary*)arrayOftablesDictionary
{
    MapModel *mapModel = [[MapModel alloc] init];
    
    for ( NSMutableDictionary *tableDictionary in arrayOftablesDictionary ) {
        TableModel *tableToAddToMap;
        tableToAddToMap=[[TableModel alloc] initWithId:[[tableDictionary valueForKey:kTableID] intValue]
                                              Capacity:[[tableDictionary valueForKey:kTableCapacity]intValue]
                                                height:[[tableDictionary valueForKey:kTableHeight]intValue]
                                              isActive:[[tableDictionary valueForKey:kTableisActive] boolValue]
                                                isFree:[[tableDictionary valueForKey:kTableIsFree]boolValue]
                                               isRound:[[tableDictionary valueForKey:kTableIsRound]intValue]
                                                  name:[tableDictionary valueForKey:kTableName]
                                              rotation:[[tableDictionary valueForKey:kTableRotation]intValue]
                                                 width:[[tableDictionary valueForKey:kTablewWidth]intValue]
                                                coordX:[[tableDictionary valueForKey:kTableX]intValue]
                                                coordY:[[tableDictionary valueForKey:kTableY]intValue]
                         ];
        [mapModel addTableModel:tableToAddToMap];
    }
    return mapModel;
    
}

@end
