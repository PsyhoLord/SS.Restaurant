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

static NSString *const ID          = @"Id";
static NSString *const capacity    = @"Capacity";
static NSString *const height      = @"Height";
static NSString *const isActive    = @"IsActive";
static NSString *const isFree      = @"IsFree";
static NSString *const isRound     = @"IsRound";
static NSString *const name        = @"Name";
static NSString *const rotation    = @"Rotation";
static NSString *const width       = @"Width";
static NSString *const x           = @"X";
static NSString *const y           = @"Y";

@implementation MapDataParser

+ (id)parse:(NSData*) data parseError:(NSError**) parseError
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

+ (MapModel*)parseDictionary:(NSMutableDictionary*)tableDictionary
{
    MapModel *mapModel = [[MapModel alloc] init];
    
    for ( NSMutableDictionary *wholeMap in tableDictionary ) {
        TableModel *tableToAddToMap;
        tableToAddToMap=[[TableModel alloc] initWithId:[[wholeMap valueForKey:ID] intValue]
                                              Capacity:[[wholeMap valueForKey:capacity]intValue]
                                                height:[[wholeMap valueForKey:height]intValue]
                                              isActive:[[wholeMap valueForKey:isActive] boolValue]
                                                isFree:[[wholeMap valueForKey:isFree]boolValue]
                                               isRound:[[wholeMap valueForKey:isRound]intValue]
                                                  name:[wholeMap valueForKey:name]
                                              rotation:[[wholeMap valueForKey:rotation]intValue]
                                                 width:[[wholeMap valueForKey:width]intValue]
                                                coordX:[[wholeMap valueForKey:x]intValue]
                                                coordY:[[wholeMap valueForKey:y]intValue]
                         ];
        [mapModel addTableModel:tableToAddToMap];
    }
    return mapModel;
    
}

@end
