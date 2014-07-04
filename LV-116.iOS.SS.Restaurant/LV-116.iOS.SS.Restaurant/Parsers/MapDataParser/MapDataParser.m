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
        tableToAddToMap=[[TableModel alloc] initWithId:[[tableDictionary valueForKey:ID] intValue]
                                              Capacity:[[tableDictionary valueForKey:capacity]intValue]
                                                height:[[tableDictionary valueForKey:height]intValue]
                                              isActive:[[tableDictionary valueForKey:isActive] boolValue]
                                                isFree:[[tableDictionary valueForKey:isFree]boolValue]
                                               isRound:[[tableDictionary valueForKey:isRound]intValue]
                                                  name:[tableDictionary valueForKey:name]
                                              rotation:[[tableDictionary valueForKey:rotation]intValue]
                                                 width:[[tableDictionary valueForKey:width]intValue]
                                                coordX:[[tableDictionary valueForKey:x]intValue]
                                                coordY:[[tableDictionary valueForKey:y]intValue]
                         ];
        [mapModel addTableModel:tableToAddToMap];
    }
    return mapModel;
    
}

@end
